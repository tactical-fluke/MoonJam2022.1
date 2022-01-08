extends StaticBody2D

export (int, 0, 1) var enabled_plane = 0

export (bool) var switchable

var plane_manager

# Called when the node enters the scene tree for the first time.
func _ready():
	if switchable:
		plane_manager = get_node("/root/root/PlaneManager")
		if plane_manager != null:
			plane_manager.connect("switched_plane", self, "_on_plane_switched")
		else:
			print("Could not find the PlaneManager")
			
		_on_plane_switched(0)


func _on_plane_switched(plane):
	if plane != enabled_plane:
		$CollisionShape2D.call_deferred("set_disabled", true)
		hide()
	else:
		$CollisionShape2D.call("set_disabled", false)
		show()
