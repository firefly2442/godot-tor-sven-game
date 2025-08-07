extends Node2D

var overlapping: bool = false ## if the player vehicle is overlapping with this
var p1_agrees: bool = false ## if player 1 has agreed the colors are the same
var p2_agrees: bool = false ## if player 2 has agreed the colors are the same
var finished: bool = false ## whether or not the mission is finished

var common_colors: Array = [
		Color.RED,
		Color.GREEN,
		Color.BLUE,
		Color.YELLOW,
		Color.ORANGE
	]

func _ready() -> void:
	self.global_position = pick_random_spawn_position(get_tree().root.get_node("City").get_node("TileMapLayer_MissionSpawn"))
	self.z_index = 50 # make sure it's visible on top of our other items like the tilemap
	%PickupMissionContent.visible = false
	%HeartsParticles.visible = false
	%Color1.modulate = common_colors[randi_range(0, common_colors.size() - 1)]
	%Color2.modulate = common_colors[randi_range(0, common_colors.size() - 1)]

func pick_random_spawn_position(tile_map_layer: TileMapLayer) -> Vector2:
	var candidates: Array = tile_map_layer.get_used_cells()
	if candidates.is_empty():
		push_error("No spawnable tiles found")
		return Vector2.ZERO
	var chosen: Vector2 = candidates[randi() % candidates.size()]
	return tile_map_layer.map_to_local(chosen)


func _on_area_entered(_area: Area2D) -> void:
	overlapping = true
	if not finished:
		var pickup_node := self.get_node_or_null("PickupMissionContent")
		if pickup_node:
			pickup_node.visible = true
		var timer := self.get_node_or_null("QuestionTimer")
		if timer:
			timer.start(6)

func _on_area_exited(_area: Area2D) -> void:
	overlapping = false
	if not finished:
		var pickup_node := self.get_node_or_null("PickupMissionContent")
		if pickup_node:
			pickup_node.visible = false
		var timer := self.get_node_or_null("QuestionTimer")
		if timer:
			timer.stop()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("action_p1") and overlapping:
		p1_agrees = true
		AudioManager.playUIClick()
	if Input.is_action_just_pressed("action_p2") and overlapping:
		p2_agrees = true
		AudioManager.playUIClick()
	
	if %Color1.modulate == %Color2.modulate and p1_agrees and p2_agrees and overlapping:
		finished = true
		%Area2D.set_process(false)
		%Area2D.set_physics_process(false)
		%PickupMissionContent.visible = false
		%HeartsParticles.visible = true
		%FinishPickupTimer.start()

func _on_question_timer_timeout() -> void:
	p1_agrees = false
	p2_agrees = false
	%Color1.modulate = common_colors[randi_range(0, common_colors.size() - 1)]
	%Color2.modulate = common_colors[randi_range(0, common_colors.size() - 1)]

func _process(_delta: float) -> void:
	%TimerProgressBar.value = round((%QuestionTimer.time_left / 6) * 100)


func _on_finish_pickup_timer_timeout() -> void:
	self.queue_free()
