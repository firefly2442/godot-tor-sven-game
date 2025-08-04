extends Node2D

@onready var playervehicle: Node = preload("uid://dawpfnhd7ujd6").instantiate()

func _ready() -> void:
	# set the player in the middle of the screen
	playervehicle.z_index = 100 # always draw the vehicle on top
	playervehicle.global_position = Vector2(100, 100) # place the vehicle on the road
	self.add_child(playervehicle)
	%PreventMovementTileMapLayer.z_index = -1 # don't show our red Xs that prevent movement
	%TileMapLayer_MissionSpawn.z_index = -1 # don't show our special mission spawn tiles
	%Player1Role.text = Utility.player1_selected
	%Player2Role.text = Utility.player2_selected
	MissionGenerator.clearMissions() # clear any potential past missions
	MissionGenerator.startGeneratingMissions() # start generating missions
	AudioManager.playBackgroundEnvironmental()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape_p1") or event.is_action_pressed("escape_p2"):
		Utility.paused = true
		get_tree().paused = true
		self.add_child(load("uid://x45urlgxnu8f").instantiate())

func _process(_delta: float) -> void:
	%MissionStatusLabel.text = MissionGenerator.mission_type + " - " + str(MissionGenerator.get_node("Missions").get_child_count())
