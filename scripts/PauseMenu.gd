extends CanvasLayer

var selected_index: int = 0
@onready var menuitems: Array[Node] = %MenuItems.get_children()

func _ready() -> void:
	self.process_mode = Node.ProcessMode.PROCESS_MODE_ALWAYS  # ensure this menu works while paused
	update_selection()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("down_p1") or event.is_action_pressed("down_p2"):
		selected_index = (selected_index + 1) % menuitems.size()
		update_selection()
	elif event.is_action_pressed("up_p1") or event.is_action_pressed("up_p2"):
		selected_index = (selected_index - 1 + menuitems.size()) % menuitems.size()
		update_selection()
	elif event.is_action_pressed("action_p1") or event.is_action_pressed("action_p2"):
		_on_item_selected(selected_index)

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
		self.queue_free()  # remove the menu
	elif index == 1:
		SceneSwitcher.switch_scene("uid://bky45hik6v0r0") # Main Menu
