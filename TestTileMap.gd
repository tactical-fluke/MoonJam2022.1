extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("switch_plane"):
		print("key pressed")
		var tiles = get_used_cells()
		var allowed_tiles = tile_set.get_tiles_ids()
		for tile in tiles:
			var index = get_array_id_for_tile(allowed_tiles, get_cellv(tile))
			if index != -1:
				set_cellv(tile, allowed_tiles[(index + 1) % allowed_tiles.size()])
			

func get_array_id_for_tile(tile_ids, tile):
	for i in tile_ids.size():
		if tile == tile_ids[i]:
			return i
	return -1
