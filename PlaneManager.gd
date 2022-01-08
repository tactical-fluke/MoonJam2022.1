extends Node

signal switched_plane(plane)

var plane = 0

func _process(delta):
	if Input.is_action_just_pressed("switch_plane"):
		plane = 0 if plane == 1 else 1
		emit_signal("switched_plane", plane)
