extends Node2D

func _process(delta):
	if Input.is_action_pressed("close"):
		get_tree().quit()