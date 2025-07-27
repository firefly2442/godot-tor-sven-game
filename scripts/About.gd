extends Node2D

@export var scroll_speed: float = 30.0  # pixels per second


func _ready() -> void:
	pass

func _process(delta) -> void:
	var scroll = $%ScrollContainer
	var v_scrollbar = scroll.get_v_scroll_bar()
	
	if not v_scrollbar.visible:
		return  # No need to scroll if it doesn't overflow
	
	var v_scroll = v_scrollbar.value
	var max_scroll = v_scrollbar.max_value
	
	v_scroll += scroll_speed * delta
	
	if v_scroll > max_scroll:
		v_scroll = 0
	v_scrollbar.value = v_scroll

func _unhandled_input(_event):
	if Input.is_action_just_pressed("action_p1") or Input.is_action_just_pressed("action_p2") or Input.is_action_just_pressed("back_p1") or Input.is_action_just_pressed("back_p2"):
		SceneSwitcher.switch_scene("uid://bky45hik6v0r0") # Main Menu
