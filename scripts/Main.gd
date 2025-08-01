extends Node


func _ready() -> void:
	var connected_pads: Array[int] = Input.get_connected_joypads()

	# Setup input for Player 1 (Controller 0)
	if connected_pads.has(0):
		_add_controller_input("p1", 0)
	# Setup input for Player 2 (Controller 1)
	if connected_pads.has(1):
		_add_controller_input("p2", 1)
	
	SceneSwitcher.switch_scene("uid://bky45hik6v0r0") # Main Menu


func _add_controller_input(player_prefix: String, device_id: int) -> void:
	var actions: Dictionary = {
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
		},
		"escape": {
			"type": "button",
			"button_index": JOY_BUTTON_START  # start button on Xbox controller
		}
	}

	for action_name: Array in actions.keys():
		var input_action: String = "%s_%s" % [action_name, player_prefix]

		# Clear old mappings to avoid duplicates
		#InputMap.action_erase_events(input_action)

		var config: Variant = actions[action_name]
		
		if config.type == "button":
			var event: Object = InputEventJoypadButton.new()
			event.device = device_id
			event.button_index = config.button_index
			InputMap.action_add_event(input_action, event)

		elif config.type == "axis":
			var event: Object = InputEventJoypadMotion.new()
			event.device = device_id
			event.axis = config.axis
			event.axis_value = config.axis_value
			InputMap.action_add_event(input_action, event)
