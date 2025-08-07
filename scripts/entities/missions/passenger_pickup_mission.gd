extends Node2D

var overlapping: bool = false ## if the player vehicle is overlapping with this
var p1_agrees: bool = false
var p2_agrees: bool = false

func _ready() -> void:
	self.global_position = pick_random_spawn_position(get_tree().root.get_node("City").get_node("TileMapLayer_MissionSpawn"))
	self.z_index = 50 # make sure it's visible on top of our other items like the tilemap
	%PickupMissionContent.visible = false

func pick_random_spawn_position(tile_map_layer: TileMapLayer) -> Vector2:
	var candidates: Array = tile_map_layer.get_used_cells()
	if candidates.is_empty():
		push_error("No spawnable tiles found")
		return Vector2.ZERO
	var chosen: Vector2 = candidates[randi() % candidates.size()]
	return tile_map_layer.map_to_local(chosen)


func _on_area_entered(_area: Area2D) -> void:
	overlapping = true
	var pickup_node := self.get_node_or_null("PickupMissionContent")
	if pickup_node:
		pickup_node.visible = true
		%QuestionTimer.start(5)

func _on_area_exited(_area: Area2D) -> void:
	overlapping = false
	var pickup_node := self.get_node_or_null("PickupMissionContent")
	if pickup_node:
		pickup_node.visible = false
		%QuestionTimer.stop()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("action_p1"):
		p1_agrees = true
	if Input.is_action_just_pressed("action_p2"):
		p2_agrees = true

func _on_question_timer_timeout() -> void:
	pass

func _process(_delta: float) -> void:
	%TimerProgressBar.value = round(%QuestionTimer.time_left / 6)
