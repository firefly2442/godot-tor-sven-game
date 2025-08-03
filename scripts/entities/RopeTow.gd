extends Node2D

# I tried both PinJoint2D and DampedSpringJoint2D
# The PinJoint2D seemed to look better, the DampedSpringJoint2D would stretch
# out way too long.

func _ready() -> void:
	# attach to the player vehicle
	%PinJoint2D.node_a = self.get_parent().get_path()
	self.visible = true

func showTowedCar() -> void:
	self.visible = true
