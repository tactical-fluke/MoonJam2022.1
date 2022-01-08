extends Node

signal switched_plane(plane)

export (AudioStreamMP3) var plane_1_track
export (AudioStreamMP3) var plane_2_track

var plane = 0

export var volume = 10
export var silence_volume = -1000

func _ready():
	$Track1.stream = plane_1_track
	$Track2.stream = plane_2_track
	
	$Track1.play()
	$Track2.play()
	$Track1.volume_db = volume
	$Track2.volume_db = silence_volume

func _process(delta):
	if Input.is_action_just_pressed("switch_plane"):
		plane = 0 if plane == 1 else 1
		emit_signal("switched_plane", plane)
		
		if plane == 0:
			$Track1.volume_db = volume
			$Track2.volume_db = silence_volume
		else:
			$Track1.volume_db = silence_volume
			$Track2.volume_db = volume
