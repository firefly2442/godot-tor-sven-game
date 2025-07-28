extends Node2D

@export var rotation_speed: float = 30.0  # Degrees per second
@onready var menuitems: Array[Node] = $%MenuContainer.get_children()
var selected_index: int = 0
var model_list: Array[String] = ["ambulance", "garbage-truck", "police", "tractor", "truck", "firetruck"]

func _ready():
	randomize()  # Ensures different results each run
	var number = randi() % model_list.size()
	
	var glb_resource = load("res://models/"+model_list[number]+".glb")
	if glb_resource is PackedScene:
		var glb_instance = glb_resource.instantiate()
		%GLBModel.add_child(glb_instance)
	
	update_selection()

func _process(delta) -> void:
	%GLBModel.rotate_y(deg_to_rad(rotation_speed * delta))

func _unhandled_input(event):
	if event.is_action_pressed("down_p1") or event.is_action_pressed("down_p2"):
		selected_index = (selected_index + 1) % menuitems.size()
		update_selection()
	elif event.is_action_pressed("up_p1") or event.is_action_pressed("up_p2"):
		selected_index = (selected_index - 1 + menuitems.size()) % menuitems.size()
		update_selection()
	elif event.is_action_pressed("action_p1") or event.is_action_pressed("action_p2"):
		_on_item_selected(selected_index)

func update_selection():
	for i in range(menuitems.size()):
		var item: Node = menuitems[i]
		if i == selected_index:
			item.modulate = Color.YELLOW
		else:
			item.modulate = Color.WHITE

func _on_item_selected(index):
	if index == 0:
			SceneSwitcher.switch_scene("uid://di0q3ok3ocsaj") # New Game
	elif index == 1:
		SceneSwitcher.switch_scene("uid://b35ghe84mnrs") # Options
	elif index == 2:
		SceneSwitcher.switch_scene("uid://bksrdmi7ug4ve") # About
	elif index == 3:
		# quit the game
		get_tree().quit()
