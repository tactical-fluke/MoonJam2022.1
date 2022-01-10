extends KinematicBody2D

export (int) var speed = 400
export (int) var jump_speed = -600
export (int) var gravity_scale = 2000

export (float, 0.0, 1.0) var acceleration = 0.25
export (float, 0.0, 1.0) var friction = 0.1

export (int) var max_speed = 800

var velocity = Vector2.ZERO

var num_jumps = 0

var animated_sprite

func _ready():
	var plane_manager = get_node("/root/root/PlaneManager")
	if plane_manager:
		plane_manager.connect("switched_plane", self, "_on_plane_switched")
	else:
		print("Could not find PlaneManager")
		
	_on_plane_switched(0)
	$JumpNoise.stream

func _on_plane_switched(layer):
	if layer == 0:
		animated_sprite = $Layer1_Sprite
		$Layer2_Sprite.hide()
		$Layer1_Sprite.show()
	else:
		animated_sprite = $Layer2_Sprite
		$Layer1_Sprite.hide()
		$Layer2_Sprite.show()

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
	if is_on_floor():
		num_jumps = 0
	get_input()
	velocity.y += gravity_scale * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() || num_jumps < 1:
			num_jumps += 1
			velocity.y = jump_speed
			$JumpNoise.play()
			
	handle_animation()
	
func handle_animation():
	animated_sprite.flip_h = velocity.x > 1
	
	if velocity.y < 0:
		animated_sprite.play("Jump")
	elif velocity.y > 0:
		animated_sprite.play("Fall")
	elif abs(velocity.x) > 1:
		animated_sprite.play("Run")
	else:
		animated_sprite.play("Idle")
