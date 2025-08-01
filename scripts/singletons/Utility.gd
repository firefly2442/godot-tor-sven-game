extends Node

var player1_selected: String = "Driver"
var player2_selected: String = "Operator"

var paused: bool = false

var selected_vehicle: vehicle_resource = preload("uid://blmojbbdjr07").duplicate()
var operator_equipment: Node = preload("uid://voobn11yad5i").instantiate()
