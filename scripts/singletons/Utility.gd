extends Node

var player1_selected: String = "Driver" ## selected role, either Driver or Operator
var player2_selected: String = "Operator" ## selected role, either Driver or Operator
var player1_controls: String = "Keyboard" ## player 1 controls, either Keyboard or Controller
var player2_controls: String = "Keyboard" ## player 2 controls, either Keyboard or Controller

var paused: bool = false ## boolean, whether or not the game is paused

var selected_vehicle: vehicle_resource = preload("uid://blmojbbdjr07").duplicate() ## the selected vehicle resource
var operator_equipment: Node = preload("uid://voobn11yad5i").instantiate() ## the selected equipment as a scene
