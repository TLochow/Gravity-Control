extends Node2D

var PLANETSCENE = preload("res://scenes/Planet.tscn")

onready var MainCamera = $Camera2D

var AveragePos = Vector2(0.0, 0.0)
var MaxDistance = 0.1

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	elif event.is_action_pressed("mouse_click"):
		SpawnPlanet()

func _process(delta):
	CalculateDistances()
	PlaceCamera()

func CalculateDistances():
	var gravityBodies = get_tree().get_nodes_in_group("GravityObject")
	var bodyCount = gravityBodies.size()
	if bodyCount > 0:
		AveragePos = Vector2(0.0, 0.0)
		for body in gravityBodies:
			AveragePos += body.get_position()
		AveragePos /= bodyCount
		MaxDistance = 0.1
		for body in gravityBodies:
			MaxDistance = max(MaxDistance, abs((AveragePos - body.get_position()).length()))

func PlaceCamera():
	MainCamera.set_position(AveragePos)
	MainCamera.zoom = lerp(MainCamera.zoom, Vector2(1.0, 1.0) * (max(MaxDistance, 300.0) / 200.0), 0.1)

func SpawnPlanet():
	var planet = PLANETSCENE.instance()
	planet.set_position(.get_global_mouse_position())
	$Planets.add_child(planet)

func _on_PlanetTimer_timeout():
	var planet = PLANETSCENE.instance()
	var pos = Vector2(rand_range(-500.0, 500.0), rand_range(-250.0, 250.0)) * MainCamera.zoom * 0.5
	planet.set_position(pos + AveragePos)
	$Planets.add_child(planet)
