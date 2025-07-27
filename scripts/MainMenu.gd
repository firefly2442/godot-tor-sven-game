extends Node2D

@export var rotation_speed: float = 30.0  # Degrees per second

var model_list: Array = ["ambulance", "garbage-truck", "police", "tractor", "truck", "firetruck"]

func _ready():
	randomize()  # Ensures different results each run
	var number = randi() % model_list.size()
	
	var glb_resource = load("res://models/"+model_list[number]+".glb")
	if glb_resource is PackedScene:
		var glb_instance = glb_resource.instantiate()
		%GLBModel.add_child(glb_instance)

func _on_quit_btn_pressed() -> void:
	# quit the game
	get_tree().quit()

func _on_new_game_btn_pressed() -> void:
	SceneSwitcher.switch_scene("uid://di0q3ok3ocsaj") # New Game

func _on_options_btn_pressed() -> void:
	SceneSwitcher.switch_scene("uid://b35ghe84mnrs") # Options

func _on_about_btn_pressed() -> void:
	SceneSwitcher.switch_scene("uid://bksrdmi7ug4ve") # About

func _process(delta) -> void:
	%GLBModel.rotate_y(deg_to_rad(rotation_speed * delta))
	
