extends ParallaxBackground

export (int, 0, 1) var enabled_plane

# Called when the node enters the scene tree for the first time.
func _ready():
	var plane_manager = get_node("/root/root/PlaneManager")
	if plane_manager:
		plane_manager.connect("switched_plane", self, "_on_plane_switched")
	else:
		print("Could not find the PlaneManager")
		
	_on_plane_switched(0)
		

func _on_plane_switched(plane):
	if plane == enabled_plane:
		show()
	else:
		hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show():
	$Backdrop/Sprite.show()
	$background/TextureRect.show()
	$midground/TextureRect.show()
	$foreground/TextureRect.show()
	
func hide():
	$Backdrop/Sprite.hide()
	$background/TextureRect.hide()
	$midground/TextureRect.hide()
	$foreground/TextureRect.hide()
