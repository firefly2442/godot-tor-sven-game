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

func _ready() -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	if Utility.player1_selected == "Driver" and Input.is_action_just_pressed("left_p1") and selected_vehicle_index != 0:
		selected_vehicle_index = selected_vehicle_index - 1
	if Utility.player1_selected == "Driver" and Input.is_action_just_pressed("right_p1") and selected_vehicle_index != available_vehicles.size()-1:
		selected_vehicle_index = selected_vehicle_index + 1
	if Utility.player2_selected == "Driver" and Input.is_action_just_pressed("left_p2") and selected_vehicle_index != 0:
		selected_vehicle_index = selected_vehicle_index - 1
	if Utility.player2_selected == "Driver" and Input.is_action_just_pressed("right_p2") and selected_vehicle_index != available_vehicles.size()-1:
		selected_vehicle_index = selected_vehicle_index + 1
		
	if Input.is_action_just_pressed("action_p1"):
		player1_ready = true
		$%Player1ReadyLabel.modulate = Color.GREEN
	if Input.is_action_just_pressed("action_p2"):
		player2_ready = true
		$%Player2ReadyLabel.modulate = Color.GREEN
	if Input.is_action_just_pressed("back_p1"):
		player1_ready = false
		$%Player1ReadyLabel.modulate = Color.WHITE
	if Input.is_action_just_pressed("back_p2"):
		player2_ready = false
		$%Player2ReadyLabel.modulate = Color.WHITE

func _process(_delta: float) -> void:
	var vehicle: vehicle_resource = load(available_vehicles[selected_vehicle_index]).duplicate()
	$%VehicleTextureRect.texture = vehicle.texture
	$%VehicleLabel.text = vehicle.vehicle_type.keys()[vehicle.vehicletype]
	
	Utility.selected_vehicle = vehicle
	
	if player1_ready and player2_ready:
		SceneSwitcher.switch_scene("uid://y2yrudm57l61") # Load into the City
