extends Node2D

@export var rotation_speed: float = 30.0  # Degrees per second
@onready var menuitems: Array[Node] = %MenuContainer.get_children()
var selected_index: int = 0
var model_list: Array[String] = [
	UID.VEHICLE_MODELS.AMBULANCE,
	UID.VEHICLE_MODELS.FIRETRUCK,
	UID.VEHICLE_MODELS.GARBAGE_TRUCK,
	UID.VEHICLE_MODELS.POLICECAR,
	UID.VEHICLE_MODELS.TRACTOR,
	UID.VEHICLE_MODELS.TRUCK,
]
var move_cooldown: float = 0.3  # seconds between menu moves
var time_until_next: float = 0.0

func _ready() -> void:
	self.time_until_next = 0.5
	if get_tree().root.has_node("City"):
		get_tree().root.get_node("City").queue_free()  # remove and clear if it exists
	Utility.selected_vehicle = null
	MissionGenerator.clearMissions()
	
	AudioManager.playGeneric()
	
	randomize()  # Ensures different results each run
	
	var glb_resource: PackedScene = load(model_list.pick_random())
	if glb_resource is PackedScene:
		var glb_instance: Node = glb_resource.instantiate()
		%GLBModel.add_child(glb_instance)
	
	update_selection()

func _process(delta: float) -> void:
	%GLBModel.rotate_y(deg_to_rad(rotation_speed * delta))
	
	if time_until_next > 0.0:
		time_until_next -= delta
	
	%PathFollow2D.progress_ratio += delta * 0.5
	
	if time_until_next <= 0.0:
		if Input.is_action_pressed("down_p1") or Input.is_action_pressed("down_p2"):
			selected_index = (selected_index + 1) % menuitems.size()
			AudioManager.playUISwitch()
			update_selection()
			time_until_next = move_cooldown
		elif Input.is_action_pressed("up_p1") or Input.is_action_pressed("up_p2"):
			selected_index = (selected_index - 1 + menuitems.size()) % menuitems.size()
			AudioManager.playUISwitch()
			update_selection()
			time_until_next = move_cooldown
		elif Input.is_action_pressed("action_p1") or Input.is_action_pressed("action_p2"):
			AudioManager.playUIClick()
			_on_item_selected(selected_index)
			time_until_next = move_cooldown

func update_selection() -> void:
	for i in range(menuitems.size()):
		var item: Node = menuitems[i]
		if i == selected_index:
			item.modulate = Color.GREEN
		else:
			item.modulate = Color.WHITE

func _on_item_selected(index: int) -> void:
	if index == 0:
		SceneSwitcher.switch_scene(UID.CORE.NEWGAMESETUP)
	elif index == 1:
		SceneSwitcher.switch_scene(UID.CORE.CONTROLS)
	elif index == 2:
		SceneSwitcher.switch_scene(UID.CORE.OPTIONS)
	elif index == 3:
		SceneSwitcher.switch_scene(UID.CORE.ABOUT)
	elif index == 4:
		# quit the game
		get_tree().quit()
