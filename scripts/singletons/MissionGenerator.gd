extends Node2D

@export var max_missions: int = 6 ## maximum number of active missions at once
var mission_type: String = "Pending"

func _ready() -> void:
	pass

func clearMissions() -> void:
	for child in %Missions.get_children():
		child.queue_free()

func startGeneratingMissions() -> void:
	%Timer.start()

func stopGeneratingMissions() -> void:
	%Timer.stop()

func _on_timer_timeout() -> void:
	if %Missions.get_child_count() < max_missions:
		if Utility.selected_vehicle.vehicletype != null and Utility.selected_vehicle.vehicletype == vehicle_resource.vehicle_type.AMBULANCE:
			%Missions.add_child(load("uid://5lqelcy8ffdx").instantiate())
			mission_type = "Rescue"
		elif Utility.selected_vehicle.vehicletype != null and Utility.selected_vehicle.vehicletype == vehicle_resource.vehicle_type.FIRETRUCK:
			%Missions.add_child(load("uid://bhff7y7sbn8ga").instantiate())
			mission_type = "Fire"
		elif Utility.selected_vehicle.vehicletype != null and Utility.selected_vehicle.vehicletype == vehicle_resource.vehicle_type.POLICECAR:
			%Missions.add_child(load("uid://5lqelcy8ffdx").instantiate())
			mission_type = "Rescue"
		elif Utility.selected_vehicle.vehicletype != null and Utility.selected_vehicle.vehicletype == vehicle_resource.vehicle_type.SCHOOLBUS:
			%Missions.add_child(load("uid://c5d8y5gfpb7a0").instantiate())
			mission_type = "Passenger Pickup"
		elif Utility.selected_vehicle.vehicletype != null and Utility.selected_vehicle.vehicletype == vehicle_resource.vehicle_type.TOWTRUCK:
			%Missions.add_child(load("uid://bfxrg30dyb8cp").instantiate())
			mission_type = "Car Pickup"
		else:
			mission_type = "Pending"
	%Timer.start() # restart the timer

func fireOut(staticbody2d_id: int) -> void:
	# check to see which fire we should put out
	for mission in %Missions.get_children():
		mission.fireOut(staticbody2d_id)

func checkTowTruckPickup() -> bool:
	for mission in %Missions.get_children():
		if mission.checkCarPickup():
			return true
	return false
