extends Node2D

# I tried both PinJoint2D and DampedSpringJoint2D
# The PinJoint2D seemed to look better, the DampedSpringJoint2D would stretch
# out way too long.

signal check_tow_truck_pickup()

func _ready() -> void:
	# attach to the player vehicle
	%PinJoint2D.node_a = self.get_parent().get_path()
	self.visible = false
	connect("check_tow_truck_pickup", Callable(MissionGenerator, "checkTowTruckPickup"))

func showTowedCar() -> void:
	self.visible = true

func _physics_process(_delta: float) -> void:
	if (Utility.player1_selected == "Operator" and Input.is_action_just_pressed("action_p1")) or \
	(Utility.player2_selected == "Operator" and Input.is_action_just_pressed("action_p2")):
		check_tow_truck_pickup.emit()
		if MissionGenerator.checkTowTruckPickup():
			self.visible = true
