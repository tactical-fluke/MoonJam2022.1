extends KinematicBody2D

export (int, -1, 1) var start_direction = 0

export (float) var speed

var distance_mult = 4

var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = start_direction


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
