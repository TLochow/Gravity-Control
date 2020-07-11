extends RigidBody2D

var Radius = 16.0

func _ready():
	mass = rand_range(50.0, 500.0)
	linear_velocity = Vector2(rand_range(-500.0, 500.0), rand_range(-500.0, 500.0))
	$Sprite.modulate = Color.from_hsv(randf(), 1.0, 1.0)
	SetSize()

func SetSize():
	var scale = mass / 100.0
	$Sprite.scale = Vector2(1.0, 1.0) * scale
	var shape = CircleShape2D.new()
	Radius = scale * 16.0
	shape.set_radius(Radius)
	$CollisionShape2D.shape = shape

func _physics_process(delta):
	Global.CalculateGravity(self, delta)
