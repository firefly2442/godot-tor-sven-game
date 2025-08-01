extends Node2D

@onready var playervehicle: Node = preload("uid://dawpfnhd7ujd6").instantiate()

func _ready() -> void:
	# set the player in the middle of the screen
	playervehicle.z_index = 100 # always draw it on top
	self.add_child(playervehicle)
