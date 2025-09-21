extends Node2D

var _settings: Dictionary = {fullscreen = false}
@onready var selectable_items: Array = [%Fullscreen, %BackgroundMusicHSlider, %SoundEffectsHSlider, %BackButton]
var current_selected_index: int = 0
var move_cooldown: float = 0.3  # seconds between menu moves
var time_until_next: float = 0.0

func _ready() -> void:
	self.time_until_next = 0.5
	
	self._settings.fullscreen = ((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))
	%Fullscreen.button_pressed = self._settings.fullscreen
	
	%BackgroundMusicHSlider.value = AudioManager.backgroundvolume
	%SoundEffectsHSlider.value = AudioManager.effectsvolume
	
	%Fullscreen.grab_focus()


func _process(delta: float) -> void:
	if time_until_next > 0.0:
		time_until_next -= delta
		
	if time_until_next <= 0.0:
		if Input.is_action_just_pressed("back_p1") or Input.is_action_just_pressed("back_p2") or \
		Input.is_action_just_pressed("escape_p1") or Input.is_action_just_pressed("escape_p2"):
			SceneSwitcher.switch_scene(UID.CORE.MAINMENU)
			AudioManager.playUIClick()
		
		if Input.is_action_pressed("up_p1") or Input.is_action_pressed("up_p2"):
			current_selected_index -= 1
			current_selected_index = clamp(current_selected_index, 0, selectable_items.size()-1)
			
			AudioManager.playUIClick()
			selectable_items[current_selected_index].grab_focus()
			time_until_next = move_cooldown
		elif Input.is_action_pressed("down_p1") or Input.is_action_pressed("down_p2"):
			current_selected_index += 1
			current_selected_index = clamp(current_selected_index, 0, selectable_items.size()-1)
			
			AudioManager.playUIClick()
			selectable_items[current_selected_index].grab_focus()
			time_until_next = move_cooldown

func _on_fullscreen_pressed() -> void:
	self._settings.fullscreen = %Fullscreen.button_pressed
	
	# apply the settings
	# https://www.gdquest.com/tutorial/godot/2d/settings-demo/
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (self._settings.fullscreen) else Window.MODE_WINDOWED


func _on_back_button_pressed() -> void:
	SceneSwitcher.switch_scene(UID.CORE.MAINMENU)


func _on_background_music_h_slider_value_changed(_value: float) -> void:
	AudioManager.backgroundvolume = %BackgroundMusicHSlider.value


func _on_sound_effects_h_slider_value_changed(_value: float) -> void:
	AudioManager.effectsvolume = %SoundEffectsHSlider.value
	AudioManager.playUIClick()
