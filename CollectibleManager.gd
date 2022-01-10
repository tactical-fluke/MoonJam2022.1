extends Node

var count = 0

var collected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var collectibles = get_tree().get_nodes_in_group("Collectible")
	count = collectibles.size()
	for collectible in collectibles:
		collectible.connect("collected", self, "_on_collectible_collected")
		
	$CollectibleManagerOverlay.set_count(count)
	$CollectibleManagerOverlay.set_collected(0)


func _on_collectible_collected():
	collected += 1
	$CollectibleManagerOverlay.set_collected(collected)
	check_finished()


func check_finished():
	if collected == count:
		$VictorySound.play()
		$Timer.start()


func _on_Timer_timeout():
	get_tree().change_scene("res://MainMenu.tscn")
