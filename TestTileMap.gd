extends TileMap

export (bool) var persistent

export (int, 0, 1) var enabled_layer 

var enabled

var cached_tile_info
var cached_tile_locations

# Called when the node enters the scene tree for the first time.
func _ready():
	var plane_manager = get_node("/root/root/PlaneManager")
	if plane_manager:
		plane_manager.connect("switched_plane", self, "_on_plane_switched")
	else:
		print("Tilemap failed to find the PlaneManager")
		
	enabled = enabled_layer == 0
	cache_tile_info()
	_on_plane_switched(0)

func _on_plane_switched(layer):
	if persistent:
		swap_tiles(layer)
	else:
		toggle_tiles(layer)

func swap_tiles(layer):
	var offset = 1 if layer != enabled_layer else 0
	for tile in cached_tile_locations:
		var index = (cached_tile_info[tile] + offset) % tile_set.get_tiles_ids().size()
		if index != -1:
			set_cellv(tile, index)

func toggle_tiles(layer):
	enabled = layer == enabled_layer
	if enabled:
		for tile in cached_tile_locations:
			set_cellv(tile, cached_tile_info[tile])
	else:
		for tile in cached_tile_locations:
			set_cellv(tile, -1)

func get_array_id_for_tile(tile_ids, tile):
	for i in tile_ids.size():
		if tile == tile_ids[i]:
			return i
	return -1
	
func cache_tile_info():
	cached_tile_info = {}
	cached_tile_locations = []
	var locations = get_used_cells()
	for location in locations:
		cached_tile_locations.append(location)
		var id = get_cellv(location)
		cached_tile_info[location] = id
