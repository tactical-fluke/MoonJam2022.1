extends KinematicBody2D

export (int) var speed = 400
export (int) var jump_speed = -800
export (int) var gravity_scale = 2000

export (float, 0.0, 1.0) var acceleration = 0.25
export (float, 0.0, 1.0) var friction = 0.1

export (int) var max_speed = 800

var velocity = Vector2.ZERO

func get_input():
	var dir = 0
	if Input.is_action_pressed("walk_right"):
		dir += 1
	elif Input.is_action_pressed("walk_left"):
		dir -=1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity_scale * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		print("I collided with ", collision.collider.get_class())
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
