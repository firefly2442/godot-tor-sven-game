extends Node2D

var available_vehicles: Array[String] = [
	"uid://dhgr0cdhk6bwe",
	"uid://blmojbbdjr07",
	"uid://ccnrt1tmmm6dj",
	"uid://b6f435xspe71g",
	"uid://beu2y01pvh78r"
]
var selected_vehicle_index: int = 0

var player1_ready: bool = false
var player2_ready: bool = false

var move_cooldown: float = 0.3  # seconds between menu moves
var time_until_next: float = 0.0

func _ready() -> void:
	self.time_until_next = 0.5
	
	if (Utility.player1_selected == "Driver" and Utility.player1_controls == "Controller") or \
	(Utility.player2_selected == "Driver" and Utility.player2_controls == "Controller"):
		%LeftTextureRect.texture = load("uid://bejopfhmvqjma")
		%RightTextureRect.texture = load("uid://dljpa36kvyrrd")
	
	if Utility.player1_controls == "Keyboard":
		%Player1ReadyIconTextureRect.texture = load("uid://mtn5ek4rto25")
	elif Utility.player1_controls == "Controller":
		%Player1ReadyIconTextureRect.texture = load("uid://dt0o42ouafxkq")
	
	if Utility.player2_controls == "Keyboard":
		%Player2ReadyIconTextureRect.texture = load("uid://doc8iub0ug0w4")
	elif Utility.player2_controls == "Controller":
		%Player2ReadyIconTextureRect.texture = load("uid://dt0o42ouafxkq")

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("action_p1"):
		player1_ready = true
		%Player1ReadyLabel.modulate = Color.GREEN
		AudioManager.playUIClick()
	if Input.is_action_just_pressed("action_p2"):
		player2_ready = true
		%Player2ReadyLabel.modulate = Color.GREEN
		AudioManager.playUIClick()
	if Input.is_action_just_pressed("back_p1"):
		player1_ready = false
		%Player1ReadyLabel.modulate = Color.WHITE
		AudioManager.playUIClick()
	if Input.is_action_just_pressed("back_p2"):
		player2_ready = false
		%Player2ReadyLabel.modulate = Color.WHITE
		AudioManager.playUIClick()
	
	if Input.is_action_just_pressed("escape_p1") or Input.is_action_just_pressed("escape_p2"):
		SceneSwitcher.switch_scene("uid://bky45hik6v0r0") # Main Menu

func _process(delta: float) -> void:
	if time_until_next > 0.0:
		time_until_next -= delta
		
	var vehicle: vehicle_resource = load(available_vehicles[selected_vehicle_index]).duplicate()
	%VehicleTextureRect.texture = vehicle.texture
	%VehicleLabel.text = vehicle.vehicle_type.keys()[vehicle.vehicletype]
	
	Utility.selected_vehicle = vehicle
	
	if player1_ready and player2_ready:
		SceneSwitcher.switch_scene("uid://y2yrudm57l61") # Load into the City
		
	if time_until_next <= 0.0:
		if (Utility.player1_selected == "Driver" and Input.is_action_just_pressed("right_p1") and selected_vehicle_index != available_vehicles.size()-1) or \
		(Utility.player2_selected == "Driver" and Input.is_action_just_pressed("right_p2") and selected_vehicle_index != available_vehicles.size()-1):
			selected_vehicle_index = selected_vehicle_index + 1
			AudioManager.playUISwitch()
			time_until_next = move_cooldown
		if (Utility.player2_selected == "Driver" and Input.is_action_just_pressed("left_p2") and selected_vehicle_index != 0) or \
		(Utility.player1_selected == "Driver" and Input.is_action_just_pressed("left_p1") and selected_vehicle_index != 0):
			selected_vehicle_index = selected_vehicle_index - 1
			AudioManager.playUISwitch()
			time_until_next = move_cooldown
	
	# grey out the left and right vehicle selection icons if we are at the beginning or end
	if selected_vehicle_index == 0:
		%LeftTextureRect.modulate = Color(1,1,1,0.5)
		%LeftTextureImage.modulate = Color(1,1,1,0.5)
	else:
		%LeftTextureRect.modulate = Color(1,1,1,1)
		%LeftTextureImage.modulate = Color(1,1,1,1)
	
	if selected_vehicle_index == available_vehicles.size()-1:
		%RightTextureRect.modulate = Color(1,1,1,0.5)
		%RightTextureImage.modulate = Color(1,1,1,0.5)
	else:
		%RightTextureRect.modulate = Color(1,1,1,1)
		%RightTextureImage.modulate = Color(1,1,1,1)
