extends Node2D

var player1: VBoxContainer
var player2: VBoxContainer
var player1_label: TextureRect
var player2_label: TextureRect

var player1_ready: bool = false
var player2_ready: bool = false

func _ready() -> void:
	Utility.player1_selected = ""
	Utility.player2_selected = ""
	
	var connected_pads = Input.get_connected_joypads()
	
	player1 = %Player1Container
	player2 = %Player2Container
	player1_label = %Player1
	player2_label = %Player2
	
	if connected_pads.size() == 0:
		$%Player1.texture = load("res://images/ui/keyboard.png")
		$%Player1Label.text = "Player 1 - Keyboard"
		$%Player2.texture = load("res://images/ui/keyboard.png")
		$%Player2Label.text = "Player 2 - Keyboard"
	elif connected_pads.size() == 1:
		$%Player1.texture = load("res://images/ui/keyboard.png")
		$%Player1Label.text = "Player 1 - Keyboard"
		$%Player2.texture = load("res://images/ui/controller.png")
		$%Player2Label.text = "Player 2 - Controller"
	elif connected_pads.size() >= 2:
		$%Player1.texture = load("res://images/ui/controller.png")
		$%Player1Label.text = "Player 1 - Controller"
		$%Player2.texture = load("res://images/ui/controller.png")
		$%Player2Label.text = "Player 2 - Controller"
	
	# Setup input for Player 1 (Controller 0)
	if connected_pads.has(0):
		_add_controller_input("p1", 0)
	
	# Setup input for Player 2 (Controller 1)
	if connected_pads.has(1):
		_add_controller_input("p2", 1)

func _process(delta: float) -> void:
	if player1_ready and player2_ready and ((Utility.player1_selected == "Operator" and Utility.player2_selected == "Driver") or (Utility.player1_selected == "Driver" and Utility.player2_selected == "Operator")):
		SceneSwitcher.switch_scene("uid://b5t5uspulig2g") # Load into the Garage
	
func _unhandled_input(_event):
	if Input.is_action_just_pressed("left_p1"):
		var old_parent = player1.get_parent()
		if old_parent:
			old_parent.remove_child(player1)
			$%DriverVBoxContainer.add_child(player1)
			player1.show()
			player1.reset_size()
			Utility.player1_selected = "Driver"
	if Input.is_action_just_pressed("right_p1"):
		var old_parent = player1.get_parent()
		if old_parent:
			old_parent.remove_child(player1)
			$%OperatorVBoxContainer.add_child(player1)
			player1.show()
			player1.reset_size()
			Utility.player1_selected = "Operator"
	if Input.is_action_just_pressed("left_p2"):
		var old_parent = player2.get_parent()
		if old_parent:
			old_parent.remove_child(player2)
			$%DriverVBoxContainer.add_child(player2)
			player2.show()
			player2.reset_size()
			Utility.player2_selected = "Driver"
	if Input.is_action_just_pressed("right_p2"):
		var old_parent = player2.get_parent()
		if old_parent:
			old_parent.remove_child(player2)
			$%OperatorVBoxContainer.add_child(player2)
			player2.show()
			player2.reset_size()
			Utility.player2_selected = "Operator"
			
	if Input.is_action_just_pressed("action_p1"):
		player1_ready = true
		player1_label.modulate = Color(0,1,0,1) # green
	if Input.is_action_just_pressed("action_p2"):
		player2_ready = true
		player2_label.modulate = Color(0,1,0,1) # green
	if Input.is_action_just_pressed("back_p1"):
		player1_ready = false
		player1_label.modulate = Color(1,0,0,1) # red
	if Input.is_action_just_pressed("back_p2"):
		player2_ready = false
		player2_label.modulate = Color(1,0,0,1) # red


func _add_controller_input(player_prefix: String, device_id: int) -> void:
	var actions = {
		"left": {
			"type": "axis",
			"axis": JOY_AXIS_LEFT_X,
			"axis_value": -1.0
		},
		"right": {
			"type": "axis",
			"axis": JOY_AXIS_LEFT_X,
			"axis_value": 1.0
		},
		"up": {
			"type": "axis",
			"axis": JOY_AXIS_LEFT_Y,
			"axis_value": -1.0
		},
		"down": {
			"type": "axis",
			"axis": JOY_AXIS_LEFT_Y,
			"axis_value": 1.0
		},
		"action": {
			"type": "button",
			"button_index": JOY_BUTTON_A  # A button on Xbox controller
		},
		"back": {
			"type": "button",
			"button_index": JOY_BUTTON_B  # B button on Xbox controller
		}
	}

	for action_name in actions.keys():
		var input_action = "%s_%s" % [action_name, player_prefix]

		# Clear old mappings to avoid duplicates
		#InputMap.action_erase_events(input_action)

		var config = actions[action_name]
		
		if config.type == "button":
			var event = InputEventJoypadButton.new()
			event.device = device_id
			event.button_index = config.button_index
			InputMap.action_add_event(input_action, event)

		elif config.type == "axis":
			var event = InputEventJoypadMotion.new()
			event.device = device_id
			event.axis = config.axis
			event.axis_value = config.axis_value
			InputMap.action_add_event(input_action, event)
