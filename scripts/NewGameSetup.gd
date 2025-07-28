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
	
	var connected_pads: Array[int] = Input.get_connected_joypads()
	
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
		$%Player1.texture = load("res://images/ui/controller.png")
		$%Player1Label.text = "Player 1 - Controller"
		$%Player2.texture = load("res://images/ui/keyboard.png")
		$%Player2Label.text = "Player 2 - Keyboard"
	elif connected_pads.size() >= 2:
		$%Player1.texture = load("res://images/ui/controller.png")
		$%Player1Label.text = "Player 1 - Controller"
		$%Player2.texture = load("res://images/ui/controller.png")
		$%Player2Label.text = "Player 2 - Controller"
	

func _process(_delta: float) -> void:
	if player1_ready and player2_ready and ((Utility.player1_selected == "Operator" and Utility.player2_selected == "Driver") or (Utility.player1_selected == "Driver" and Utility.player2_selected == "Operator")):
		SceneSwitcher.switch_scene("uid://b5t5uspulig2g") # Load into the Garage
	
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_p1"):
		var old_parent: Node = player1.get_parent()
		if old_parent:
			old_parent.remove_child(player1)
			$%DriverVBoxContainer.add_child(player1)
			player1.show()
			player1.reset_size()
			Utility.player1_selected = "Driver"
	if Input.is_action_just_pressed("right_p1"):
		var old_parent: Node = player1.get_parent()
		if old_parent:
			old_parent.remove_child(player1)
			$%OperatorVBoxContainer.add_child(player1)
			player1.show()
			player1.reset_size()
			Utility.player1_selected = "Operator"
	if Input.is_action_just_pressed("left_p2"):
		var old_parent: Node = player2.get_parent()
		if old_parent:
			old_parent.remove_child(player2)
			$%DriverVBoxContainer.add_child(player2)
			player2.show()
			player2.reset_size()
			Utility.player2_selected = "Driver"
	if Input.is_action_just_pressed("right_p2"):
		var old_parent: Node = player2.get_parent()
		if old_parent:
			old_parent.remove_child(player2)
			$%OperatorVBoxContainer.add_child(player2)
			player2.show()
			player2.reset_size()
			Utility.player2_selected = "Operator"
			
	if Input.is_action_just_pressed("action_p1"):
		player1_ready = true
		player1_label.modulate = Color.GREEN
	if Input.is_action_just_pressed("action_p2"):
		player2_ready = true
		player2_label.modulate = Color.GREEN
	if Input.is_action_just_pressed("back_p1"):
		player1_ready = false
		player1_label.modulate = Color.WHITE
	if Input.is_action_just_pressed("back_p2"):
		player2_ready = false
		player2_label.modulate = Color.WHITE
