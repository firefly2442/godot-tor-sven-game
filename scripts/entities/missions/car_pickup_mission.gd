extends Node2D

var overlapping: bool = false ## if the player vehicle is overlapping with this car pickup

func _ready() -> void:
	self.global_position = pick_random_spawn_position(get_tree().root.get_node("City").get_node("TileMapLayer_Level_1"))
	self.z_index = 50 # make sure it's visible on top of our other items like the tilemap

func _get_spawnable_cells(tile_map_layer: TileMapLayer) -> Array:
	var cells: Array = []
	for cell: Vector2i in tile_map_layer.get_used_cells():
		var tdata: TileData = tile_map_layer.get_cell_tile_data(cell)
		# we added a custom data layer for our road divided dashed line
		# so this will find tiles that we can place vehicles to pick up
		var spawnable: bool = tdata.get_custom_data("spawnable")
		if spawnable:
			cells.append(cell)
	return cells

func pick_random_spawn_position(tile_map_layer: TileMapLayer) -> Vector2:
	var candidates: Array = self._get_spawnable_cells(tile_map_layer)
	if candidates.is_empty():
		push_error("No spawnable tiles found")
		return Vector2.ZERO
	var chosen: Vector2 = candidates[randi() % candidates.size()]
	return tile_map_layer.map_to_local(chosen)

func _on_area_entered(_area: Area2D) -> void:
	overlapping = true

func _on_area_exited(_area: Area2D) -> void:
	overlapping = false

func checkCarPickup() -> bool:
	if overlapping:
		self.queue_free() # this also removes it from the scene
		AudioManager.playSuccess()
		return true
	else:
		return false
