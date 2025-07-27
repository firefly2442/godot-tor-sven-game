extends Node

var num_players: int = 8

var available: Array = []  # The available players.
var queue: Array = []  # The queue of sounds to play.

var background_music: AudioStreamPlayer = AudioStreamPlayer.new()

var backgroundvolume: int = -10
var effectsvolume: int = 0

# https://kidscancode.org/godot_recipes/3.x/audio/audio_manager/

func _ready() -> void:
	# set initial volume
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("background"), self.backgroundvolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), self.effectsvolume)
	
	# Create the pool of AudioStreamPlayer nodes.
	for i in num_players:
		var p: AudioStreamPlayer = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.connect("finished", Callable(self, "_on_stream_finished").bind(p))
		p.bus = "sfx"
	
	# setup the background music
	# imported to "loop" when finished
	#add_child(background_music)
	#background_music.stream = load("res://sounds/background.ogg")
	#background_music.bus = "background"
	#background_music.play()

func _on_stream_finished(stream: Node) -> void:
	# When finished playing a stream, make the player available again.
	available.append(stream)


func play(sound_path: String) -> void:
	if sound_path not in queue:
		queue.append(sound_path)


func _process(_delta: float) -> void:
	# apply any potential volume changes
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("background"), self.backgroundvolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), self.effectsvolume)
	
	# Play a queued sound if any players are available.
	if not queue.is_empty() and not available.is_empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()
