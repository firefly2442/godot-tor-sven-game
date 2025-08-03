extends CharacterBody2D

@export var cycle_duration: float = 0.3  # time to go from red to blue and back
var time_accum: float = 0.0

func _ready() -> void:
	%VehicleSprite2D.texture = Utility.selected_vehicle.texture

	self.add_child(Utility.selected_vehicle.vehicle_equipment.instantiate())
	if Utility.selected_vehicle.vehicletype == vehicle_resource.vehicle_type.AMBULANCE or \
	Utility.selected_vehicle.vehicletype == vehicle_resource.vehicle_type.FIRETRUCK or \
	Utility.selected_vehicle.vehicletype == vehicle_resource.vehicle_type.POLICECAR:
		%PointLight2D.enabled = true
	else:
		%PointLight2D.enabled = false

	
func _unhandled_input(_event: InputEvent) -> void:
	if Utility.player1_selected == "Driver" and Input.is_action_just_pressed("left_p1") or \
	Utility.player2_selected == "Driver" and Input.is_action_just_pressed("left_p2"):
		%VehicleSprite2D.flip_h = true
		AudioManager.play(Utility.selected_vehicle.vehicle_engine_sound.resource_path)
	if Utility.player1_selected == "Driver" and Input.is_action_just_pressed("right_p1") or \
	Utility.player2_selected == "Driver" and Input.is_action_just_pressed("right_p2"):
		%VehicleSprite2D.flip_h = false
		AudioManager.play(Utility.selected_vehicle.vehicle_engine_sound.resource_path)
	if Utility.player1_selected == "Driver" and Input.is_action_just_pressed("action_p1") or \
	Utility.player2_selected == "Driver" and Input.is_action_just_pressed("action_p2"):
		AudioManager.play(Utility.selected_vehicle.vehicle_horn_sound.resource_path)
	if Utility.player1_selected == "Operator" and Input.is_action_just_pressed("back_p1") or \
	Utility.player2_selected == "Operator" and Input.is_action_just_pressed("back_p2"):
		AudioManager.play(Utility.selected_vehicle.operator_sound_back.resource_path)

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

func _process(delta: float) -> void:
	time_accum += delta
	var t: float = (sin(time_accum * PI / cycle_duration) * 0.5) + 0.5  # oscillates 0..1
	# interpolate between red and blue
	%PointLight2D.color = Color8(255, 0, 0).lerp(Color8(0, 0, 255), t)
