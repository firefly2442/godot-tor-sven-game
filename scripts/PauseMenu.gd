extends CanvasLayer

var selected_index: int = 0
@onready var menuitems: Array[Node] = %MenuItems.get_children()
var move_cooldown: float = 0.3  # seconds between menu moves
var time_until_next: float = 0.0

func _ready() -> void:
	self.time_until_next = 0.5
	self.process_mode = Node.ProcessMode.PROCESS_MODE_ALWAYS  # ensure this menu works while paused
	update_selection()

func _process(delta: float) -> void:
	if time_until_next > 0.0:
		time_until_next -= delta
		
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
		Utility.paused = false
		get_tree().paused = false
		MissionGenerator.clearMissions()
		self.queue_free()  # remove the menu
	elif index == 1:
		Utility.paused = false
		get_tree().paused = false
		AudioManager.playBackgroundMusic()
		SceneSwitcher.switch_scene("uid://bky45hik6v0r0") # Main Menu
