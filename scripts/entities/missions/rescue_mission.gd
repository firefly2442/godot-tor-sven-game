extends Node2D

var overlapping: bool = false ## if the player vehicle is overlapping with this

func _ready() -> void:
	self.global_position = pick_random_spawn_position(get_tree().root.get_node("City").get_node("TileMapLayer_MissionSpawn"))
	self.z_index = 50 # make sure it's visible on top of our other items like the tilemap
	%RescueMissionContent.visible = false
	
	if Utility.player1_controls == "Keyboard":
		%Player1Button.texture = load("uid://mtn5ek4rto25")
	elif Utility.player1_controls == "Controller":
		%Player1Button.texture = load("uid://dt0o42ouafxkq")
	
	if Utility.player2_controls == "Keyboard":
		%Player2Button.texture = load("uid://doc8iub0ug0w4")
	elif Utility.player2_controls == "Controller":
		%Player2Button.texture = load("uid://dt0o42ouafxkq")
	
	var tw1: Tween = create_tween()
	tw1.set_loops(-1)  # infinite
	tw1.tween_property(%Player1Button, "modulate", Color.GREEN, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tw1.tween_property(%Player1Button, "modulate", Color.WHITE, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	var tw2: Tween = create_tween()
	tw2.set_loops(-1)  # infinite
	tw2.tween_property(%Player2Button, "modulate", Color.GREEN, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tw2.tween_property(%Player2Button, "modulate", Color.WHITE, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func pick_random_spawn_position(tile_map_layer: TileMapLayer) -> Vector2:
	var candidates: Array = tile_map_layer.get_used_cells()
	if candidates.is_empty():
		push_error("No spawnable tiles found")
		return Vector2.ZERO
	var chosen: Vector2 = candidates[randi() % candidates.size()]
	return tile_map_layer.map_to_local(chosen)

func _on_area_entered(_area: Area2D) -> void:
	overlapping = true
	%RescueMissionContent.visible = true
	print("Visible")

func _on_area_exited(_area: Area2D) -> void:
	overlapping = false
	%RescueMissionContent.visible = false

func checkRescuePickup() -> bool:
	if overlapping:
		self.queue_free() # this also removes it from the scene
		return true
	else:
		return false
