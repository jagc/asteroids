extends Area2D

export var speed = 200
export var damage = 10

var velocity = Vector2()
var motion = Vector2()

func _process(delta):
	position += velocity * delta

func start(_position, _direction):
	position = _position
	rotation = _direction
	velocity = Vector2(speed, 0).rotated(_direction)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
