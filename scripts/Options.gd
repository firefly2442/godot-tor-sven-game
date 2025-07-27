extends Node2D

@onready var _settings: Dictionary = {resolution = Vector2i(1920, 1080), fullscreen = false, vsync = false}

func _ready() -> void:
	self._settings.fullscreen = ((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))
	%Fullscreen.button_pressed = self._settings.fullscreen
	
	self._settings.vsync = (DisplayServer.window_get_vsync_mode() != DisplayServer.VSYNC_DISABLED)
	%VSync.button_pressed = self._settings.vsync
	
	for res: int in range(0, %Resolution.get_item_count()):
		var res_str: String = %Resolution.get_item_text(res)
		var values: Array = res_str.split("x")
		if get_window().get_size() == Vector2i(int(values[0]), int(values[1])):
			%Resolution.selected = res
	
	%BackgroundMusicHSlider.value = AudioManager.backgroundvolume
	%SoundEffectsHSlider.value = AudioManager.effectsvolume


func _on_save_btn_pressed() -> void:
	var res_str: String = %Resolution.get_item_text(%Resolution.get_selected_id())
	var values: Array = res_str.split("x")
	self._settings.resolution = Vector2i(int(values[0]), int(values[1]))
	
	self._settings.fullscreen = %Fullscreen.button_pressed
	self._settings.vsync = %VSync.button_pressed
	
	AudioManager.backgroundvolume = %BackgroundMusicHSlider.value
	AudioManager.effectsvolume = %SoundEffectsHSlider.value
	
	# apply the settings
	# https://www.gdquest.com/tutorial/godot/2d/settings-demo/
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (self._settings.fullscreen) else Window.MODE_WINDOWED
	get_window().set_size(self._settings.resolution)
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if (self._settings.vsync) else DisplayServer.VSYNC_DISABLED)


func _on_cancel_btn_pressed() -> void:
	SceneSwitcher.switch_scene("res://scenes/MainMenu.tscn")
