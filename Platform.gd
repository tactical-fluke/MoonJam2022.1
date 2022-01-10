extends KinematicBody2D

export (int, 0, 1) var enabled_plane = 0

export (bool) var persistent

var plane_manager

export (Texture) var plane_1_texture
export (Texture) var plane_2_texture

export (bool) var movement = false
export (int) var move_speed
export (NodePath) var patrol_path

var patrol_points
var patrol_index = 0

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	plane_manager = get_node("/root/root/PlaneManager")
	if plane_manager != null:
		plane_manager.connect("switched_plane", self, "_on_plane_switched")
	else:
		print("Could not find the PlaneManager")
	
	_on_plane_switched(0)
	$Sprite.texture = plane_1_texture
	
	if !movement:
		return
	else:
		if patrol_path:
			patrol_points = get_node(patrol_path).curve.get_baked_points()
			
func _physics_process(delta):
	if !patrol_path:
		return
	var target = patrol_points[patrol_index]
	if position.distance_to(target) < 1:
		patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
		target = patrol_points[patrol_index]
	velocity = (target - position).normalized() * move_speed
	velocity = move_and_slide(velocity)

func _on_plane_switched(plane):
	if !persistent:
		if plane != enabled_plane:
			$CollisionShape2D.call_deferred("set_disabled", true)
			hide()
		else:
			$CollisionShape2D.call("set_disabled", false)
			show()
	else:
		if plane == 0:
			$Sprite.texture = plane_1_texture
		else:
			$Sprite.texture = plane_2_texture
			

