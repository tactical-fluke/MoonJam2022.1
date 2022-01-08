extends Button

export var level = "res://TestScene.tscn"
	
func _pressed():
	get_tree().change_scene(level)
