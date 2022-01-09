extends KinematicBody2D

export (int, -1, 1) var start_direction = 0

export (float) var speed

var distance_mult = 4

var plane_manager

export (Texture) var enemy_1_texture
export (Texture) var enemy_2_texture

onready var enemy_sprite = get_node("Enemy")

var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	plane_manager = get_node("/root/root/PlaneManager")
	if plane_manager != null:
		plane_manager.connect("switched_plane", self, "_on_plane_switched")
	else:
		print("Could not find the PlaneManager")
	_on_plane_switched(0)
	direction = start_direction
	$Sprite.texture = enemy_1_texture
	_on_plane_switched(0)


func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var check_location = position + Vector2(position.x + (direction * distance_mult), position.y - distance_mult)
	var result = space_state.intersect_ray(position, check_location, [self])
	if !result:
		swap_direction()
		
	var contact = move_and_collide(Vector2(direction * speed, 0), false)
	if !contact:
		swap_direction()

func swap_direction():
	direction = -1 if direction == 1 else 1
	
func _on_plane_switched(plane):
	if plane == 0:
		$Sprite.texture = enemy_1_texture
	else:
		$Sprite.texture = enemy_2_texture
