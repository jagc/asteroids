extends Area2D

export(PackedScene) var projectile

const TURN_SPEED = 180

const MOVE_SPEED = 150
const ACC = 0.05
const DEC = 0.01

var motion = Vector2(0,0)

var screen_size
var screen_buffer = 8

func _ready():
	screen_size = get_viewport_rect().size
	

func _process(delta):
	_movementMechanics(delta)
	_shoot(delta)
	
func _movementMechanics(delta):
	if Input.is_action_pressed("ui_left"):
		rotation_degrees -= TURN_SPEED * delta
	if Input.is_action_pressed("ui_right"):
		rotation_degrees += TURN_SPEED * delta
		
	var forwardMoveDir = Vector2(1,0).rotated(rotation)
	var reverseMoveDir = Vector2(-1,0).rotated(rotation)
	
	if Input.is_action_pressed("ui_up"):
		motion = motion.linear_interpolate(forwardMoveDir, ACC)
		$Sprite/AnimationPlayer.play("moving")
	else:
		motion = motion.linear_interpolate(Vector2(0,0), DEC)

	if Input.is_action_pressed("ui_down"):
		motion = motion.linear_interpolate(reverseMoveDir, DEC)
		$Sprite/AnimationPlayer.play("moving")

	position += motion * MOVE_SPEED * delta
	
	position.x = wrapf(position.x, -screen_buffer, screen_size.x + screen_buffer)
	position.y = wrapf(position.y, -screen_buffer, screen_size.y + screen_buffer)
	
func _shoot(delta):
	if Input.is_action_just_pressed("shoot"):
		var newProjectile = projectile.instance()
		get_parent().add_child(newProjectile)
		newProjectile.start($muzzle.global_position, rotation)