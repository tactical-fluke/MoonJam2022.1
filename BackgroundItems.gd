extends Sprite

export (int, 0, 1) var enabled_plane = 0

export (bool) var persistent

export (Texture) var plane_1_texture
export (Texture) var plane_2_texture

var plane_manager

# Called when the node enters the scene tree for the first time.
func _ready():
	plane_manager = get_node("/root/root/PlaneManager")
	if plane_manager != null:
		plane_manager.connect("switched_plane", self, "_on_plane_switched")
	else:
		print("Could not find the PlaneManager")
	
	_on_plane_switched(0)
	self.texture = plane_1_texture
			
func _on_plane_switched(plane):
	if !persistent:
		if plane != enabled_plane:
			hide()
		else:
			show()
	else:
		if plane == 0:
			self.texture = plane_1_texture
		else:
			self.texture = plane_2_texture
