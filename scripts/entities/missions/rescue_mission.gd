extends Node2D

var overlapping: bool = false ## if the player vehicle is overlapping with this

func _ready() -> void:
	self.global_position = pick_random_spawn_position(get_tree().root.get_node("City").get_node("TileMapLayer_MissionSpawn"))
	self.z_index = 50 # make sure it's visible on top of our other items like the tilemap

func pick_random_spawn_position(tile_map_layer: TileMapLayer) -> Vector2:
	var candidates: Array = tile_map_layer.get_used_cells()
	if candidates.is_empty():
		push_error("No spawnable tiles found")
		return Vector2.ZERO
	var chosen: Vector2 = candidates[randi() % candidates.size()]
	return tile_map_layer.map_to_local(chosen)

func _on_area_entered(_area: Area2D) -> void:
	overlapping = true

func _on_area_exited(_area: Area2D) -> void:
	overlapping = false

func checkRescuePickup() -> bool:
	if overlapping:
		self.queue_free() # this also removes it from the scene
		return true
	else:
		return false
