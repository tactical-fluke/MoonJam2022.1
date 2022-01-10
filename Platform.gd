extends KinematicBody2D

export (int, 0, 1) var enabled_plane = 0

export (bool) var persistent

var plane_manager

export (Texture) var plane_1_texture
export (Texture) var plane_2_texture
export (Texture) var hidden_texture

# Called when the node enters the scene tree for the first time.
func _ready():
	plane_manager = get_node("/root/root/PlaneManager")
	if plane_manager != null:
		plane_manager.connect("switched_plane", self, "_on_plane_switched")
	else:
		print("Could not find the PlaneManager")
	
	_on_plane_switched(0)
	$Sprite.texture = plane_1_texture
	if !persistent:
		if enabled_plane != 0:
			$Sprite.texture = hidden_texture

func _on_plane_switched(plane):
	if !persistent:
		if plane != enabled_plane:
			$CollisionShape2D.call_deferred("set_disabled", true)
			$Sprite.texture = hidden_texture
		else:
			$CollisionShape2D.call("set_disabled", false)
			if plane == 0:
				$Sprite.texture = plane_1_texture
			else:
				$Sprite.texture = plane_2_texture
	else:
		if plane == 0:
			$Sprite.texture = plane_1_texture
		else:
			$Sprite.texture = plane_2_texture
			

