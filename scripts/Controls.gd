extends Node2D

func _ready() -> void:
	if Input.get_connected_joypads().size() == 0:
		%Player1ControllerHBoxContainer.visible = false
		%Player2ControllerHBoxContainer.visible = false
	elif Input.get_connected_joypads().size() == 1:
		%Player2ControllerHBoxContainer.visible = false

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("action_p1") or Input.is_action_just_pressed("action_p2") or \
	Input.is_action_just_pressed("back_p1") or Input.is_action_just_pressed("back_p2") or \
	Input.is_action_just_pressed("escape_p1") or Input.is_action_just_pressed("escape_p2"):
		SceneSwitcher.switch_scene("uid://bky45hik6v0r0") # Main Menu
