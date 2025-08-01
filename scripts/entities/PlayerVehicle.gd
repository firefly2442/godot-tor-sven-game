extends CharacterBody2D

func _ready() -> void:
	%VehicleSprite2D.texture = Utility.selected_vehicle.texture
	self.add_child(Utility.operator_equipment)

func _physics_process(_delta: float) -> void:
	if not Utility.paused:
		var input_direction: Vector2
		if Utility.player1_selected == "Driver":
			input_direction = Input.get_vector("left_p1", "right_p1", "up_p1", "down_p1")
		elif Utility.player2_selected == "Driver":
			input_direction = Input.get_vector("left_p2", "right_p2", "up_p2", "down_p2")
		self.velocity = input_direction * Utility.selected_vehicle.speed
		# move_and_slide() automatically includes the timestep in its calculation, so you should not multiply the velocity vector by delta.
		move_and_slide()

func _process(_delta: float) -> void:
	pass
