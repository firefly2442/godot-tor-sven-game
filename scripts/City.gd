extends Node2D

@onready var playervehicle: Node = preload("uid://dawpfnhd7ujd6").instantiate()

func _ready() -> void:
	# set the player in the middle of the screen
	playervehicle.z_index = 100 # always draw it on top
	playervehicle.global_position = Vector2(100, 100) # place the vehicle on the road
	self.add_child(playervehicle)
	$PreventMovementTileMapLayer.z_index = -1 # don't show our red Xs that prevent movement
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape_p1") or event.is_action_pressed("escape_p2"):
		# TODO: add pause UI screen
		Utility.paused = true
