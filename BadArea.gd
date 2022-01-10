extends Area2D

signal player_entered_bad_area
signal player_left_bad_area


# Called when the node enters the scene tree for the first time.
func _ready():
	$Polygon2D.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BadArea_area_entered(area):
	if area.is_in_group("Player"):
		emit_signal("player_entered_bad_area")


func _on_BadArea_area_exited(area):
	if area.is_in_group("Player"):
		emit_signal("player_left_bad_area")
