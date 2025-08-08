extends Node

var num_players: int = 8

var available: Array = []                # pool of free players
var queue: Array = []                    # pending sound path strings
var active_sounds: Dictionary = {}       # sound_path -> true (queued or playing)
var player_to_sound: Dictionary = {}     # player -> sound_path

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
	add_child(background_music)
	playBackgroundMusic()

func _on_stream_finished(player: AudioStreamPlayer) -> void:
	# When finished playing a stream, make the player available again.
	# clear tracking so the sound can be reused
	if player in player_to_sound:
		var sound_path: String = player_to_sound[player]
		active_sounds.erase(sound_path)
		player_to_sound.erase(player)
	available.append(player)

func playBackgroundMusic() -> void:
	background_music.stream = load("uid://corfcbmyxa761")
	background_music.bus = "background"
	background_music.play()

func playBackgroundEnvironmental() -> void:
	background_music.stream = load("uid://bwsgkvpkk2a8k")
	background_music.bus = "background"
	background_music.play()

func play(sound_path: String) -> void:
	if active_sounds.has(sound_path):
		return  # already queued or playing
	queue.append(sound_path)
	active_sounds[sound_path] = true

# Stop a specific sound (queued or playing)
func stop(sound_path: String) -> void:
	# remove from queue if present
	if queue.has(sound_path):
		queue.erase(sound_path)
		active_sounds.erase(sound_path)

	# if it’s playing, find the player and stop it
	for player: Node in player_to_sound.keys():
		if player_to_sound[player] == sound_path:
			player.stop()  # immediate
			# cleanup as if finished
			active_sounds.erase(sound_path)
			player_to_sound.erase(player)
			if not available.has(player):
				available.append(player)


func _process(_delta: float) -> void:
	# apply any potential volume changes
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("background"), self.backgroundvolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), self.effectsvolume)
	
	# Play a queued sound if any players are available.
	if not queue.is_empty() and not available.is_empty():
		var sound_path: String = queue.pop_front()
		var player: AudioStreamPlayer = available.pop_front()
		player.stream = load(sound_path)
		player.play()
		player_to_sound[player] = sound_path
		# already marked active when queued

func playUISwitch() -> void:
	self.play("uid://bful7jl81wf4a")

func playUIClick() -> void:
	self.play("uid://ddbbs308w3mbk")

func playSuccess() -> void:
	if randf() > 0.5:
		return
	var sounds: Array = ["uid://iloigj1wy0n", "uid://yemb4ed6swlw"]
	self.play(sounds[randi() % sounds.size()])

func playGeneric() -> void:
	if randf() > 0.5:
		return
	var sounds: Array = ["uid://dl0s321stx7r2", "uid://b5bk3fw1ikoa2",
	"uid://cwghphc4v2ik5", "uid://dq4pkmsr4ljka", "uid://r4t0et8sdebw",
	"uid://c2gje0j5r1s1o", "uid://3v11d1vslgds", "uid://b65aiu75hxxsi",
	"uid://dtwed6i3v34p"]
	self.play(sounds[randi() % sounds.size()])
	
