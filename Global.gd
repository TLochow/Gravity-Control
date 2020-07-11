extends Node

var AllGravityObjects = Array()

func _init():
	randomize()

func _process(delta):
	AllGravityObjects = get_tree().get_nodes_in_group("GravityObject")

func CalculateGravity(ownBody, delta):
	var pos = ownBody.get_position()
	for otherBody in AllGravityObjects:
		if otherBody != ownBody:
			var otherPos = otherBody.get_position()
			var vectorToOther = otherPos - pos
			var squareDistance = clamp(vectorToOther.length_squared(), 0.1, 1000.0)
			var forceDirection = vectorToOther.normalized()
			var force = forceDirection * otherBody.mass * 100.0 / squareDistance
			if ownBody.is_in_group("Planet") and otherBody.is_in_group("Planet"):
				var minDistance = (ownBody.Radius + otherBody.Radius) * 2.0
				var distance = vectorToOther.length()
				if distance < minDistance:
					force *= range_lerp(distance, 0.0, minDistance * 0.5, -10.0, -1.0)
			ownBody.linear_velocity += force * delta
