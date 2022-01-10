extends Node

signal switched_plane(plane)

export (AudioStreamMP3) var plane_1_track
export (AudioStreamMP3) var plane_2_track

var plane = 0

export var volume = 10
export var silence_volume = -1000

var allowed_to_switch = true

func _ready():
	$Track1.stream = plane_1_track
	$Track2.stream = plane_2_track
	
	$Track1.play()
	$Track2.play()
	$Track1.volume_db = volume
	$Track2.volume_db = silence_volume
	
	var bad_areas = get_tree().get_nodes_in_group("BadArea")
	for bad_area in bad_areas:
		bad_area.connect("player_entered_bad_area", self, "_on_Player_entered_bad_area")
		bad_area.connect("player_left_bad_area", self, "_on_Player_left_bad_area")

func _process(delta):
	if Input.is_action_just_pressed("switch_plane"):
		if allowed_to_switch:
			plane = 0 if plane == 1 else 1
			emit_signal("switched_plane", plane)
			
			if plane == 0:
				$Track1.volume_db = volume
				$Track2.volume_db = silence_volume
			else:
				$Track1.volume_db = silence_volume
				$Track2.volume_db = volume
		else:
			$DisallowNoise.play()
			
func _on_Player_entered_bad_area():
	allowed_to_switch = false
	
func _on_Player_left_bad_area():
	allowed_to_switch = true
