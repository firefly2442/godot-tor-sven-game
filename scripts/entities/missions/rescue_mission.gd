extends Node2D

var overlapping: bool = false ## if the player vehicle is overlapping with this

func _ready() -> void:
	self.global_position = pick_random_spawn_position(get_tree().root.get_node("City").get_node("TileMapLayer_MissionSpawn"))
	self.z_index = 50 # make sure it's visible on top of our other items like the tilemap
	%RescueMissionContent.visible = false
	%HeartsParticles.visible = false
	
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
	var rescue_node := self.get_node_or_null("RescueMissionContent")
	if rescue_node:
		rescue_node.visible = true

func _on_area_exited(_area: Area2D) -> void:
	overlapping = false
	var rescue_node := self.get_node_or_null("RescueMissionContent")
	if rescue_node:
		rescue_node.visible = false

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("action_p1") and overlapping:
		AudioManager.playUIClick()
		%Player1ProgressBar.value += 10
	if Input.is_action_just_pressed("action_p2") and overlapping:
		AudioManager.playUIClick()
		%Player2ProgressBar.value += 10

func _on_progress_timer_timeout() -> void:
	%Player1ProgressBar.value -= 4
	%Player2ProgressBar.value -= 4

func _process(_delta: float) -> void:
	if %Player1ProgressBar.value == 100 and %Player1ProgressBar.value == 100 and overlapping:
		%Area2D.set_process(false)
		%Area2D.set_physics_process(false)
		%RescueMissionContent.visible = false
		%CharacterAnimatedSprite2D.play("happy")
		%SpeechSprite2D.texture = load("uid://ps27i7xcqs2d")
		%ExclamationParticles.visible = false
		%HeartsParticles.visible = true
		%FinishRescueTimer.start()

func _on_finish_rescue_timer_timeout() -> void:
	self.queue_free()
