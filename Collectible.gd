extends Area2D

export var persistent = false
export (int, 0, 1) var enabled_layer

export (Texture) var layer_1_texture
export (Texture) var layer_2_texture

signal collected

func _ready():
	var plane_manager = get_node("/root/root/PlaneManager")
	if plane_manager:
		plane_manager.connect("switched_plane", self, "_on_plane_switched")
	else:
		print("Tilemap failed to find the PlaneManager")
		
	$Sprite.texture = layer_1_texture
	_on_plane_switched(0)
	$Polygon2D.queue_free()


func _on_plane_switched(layer):
	if persistent:
		swap_sprite(layer)
	else:
		toggle_sprite(layer)


func swap_sprite(layer):
	if layer == 1:
		$Sprite.texture = layer_1_texture
	else:
		$Sprite.texture = layer_2_texture


func toggle_sprite(layer):
	if layer == enabled_layer:
		show()
		$CollisionShape2D.call("set_disabled", false)
	else:
		hide()
		$CollisionShape2D.call("set_disabled", true)


func _on_Collectible_area_entered(area):
	if area.is_in_group("Player"):
		emit_signal("collected")
		queue_free()
