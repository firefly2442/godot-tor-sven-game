extends Node2D

# the global positions range across the city for random mission generation
var TOP_LEFT_X: int = -1022
var TOP_LEFT_Y: int = -307
var BOTTOM_RIGHT_X: int = 1645
var BOTTOM_RIGHT_Y: int = 1337

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
			# TODO: implement
			pass
		elif Utility.selected_vehicle.vehicletype != null and Utility.selected_vehicle.vehicletype == vehicle_resource.vehicle_type.FIRETRUCK:
			var fire: Node = load("uid://bhff7y7sbn8ga").instantiate()
			fire.global_position = Vector2i(randi_range(TOP_LEFT_X, BOTTOM_RIGHT_X), randi_range(TOP_LEFT_Y, BOTTOM_RIGHT_Y))
			fire.z_index = 50 # make sure it's visible on top of our other items like the tilemap
			%Missions.add_child(fire)
			mission_type = "Fire"
		elif Utility.selected_vehicle.vehicletype != null and Utility.selected_vehicle.vehicletype == vehicle_resource.vehicle_type.POLICECAR:
			# TODO: implement
			pass
		elif Utility.selected_vehicle.vehicletype != null and Utility.selected_vehicle.vehicletype == vehicle_resource.vehicle_type.SCHOOLBUS:
			# TODO: implement
			pass
		elif Utility.selected_vehicle.vehicletype != null and Utility.selected_vehicle.vehicletype == vehicle_resource.vehicle_type.TOWTRUCK:
			var car_pickup: Node = load("uid://bfxrg30dyb8cp").instantiate()
			# TDOO: place car pickup on city map
			car_pickup.z_index = 50 # make sure it's visible on top of our other items like the tilemap
			%Missions.add_child(car_pickup)
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
