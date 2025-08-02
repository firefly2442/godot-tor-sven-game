extends Node2D

# the global positions range across the city for random mission generation
var TOP_LEFT_X: int = -1022
var TOP_LEFT_Y: int = -307
var BOTTOM_RIGHT_X: int = 1645
var BOTTOM_RIGHT_Y: int = 1337

@export var max_missions: int = 6 ## maximum number of active missions at once
var mission_type: String = "Pending"
var number_active_missions: int = 0

func _ready() -> void:
	%Timer.start()

func clearMissions() -> void:
	for child in %Missions.get_children():
		child.queue_free()


func _on_timer_timeout() -> void:
	if number_active_missions < max_missions:
		if Utility.selected_vehicle.vehicletype == vehicle_resource.vehicle_type.AMBULANCE:
			pass
		elif Utility.selected_vehicle.vehicletype == vehicle_resource.vehicle_type.FIRETRUCK:
			var fire: Node = load("uid://bhff7y7sbn8ga").instantiate()
			fire.global_position = Vector2i(randi_range(TOP_LEFT_X, BOTTOM_RIGHT_X), randi_range(TOP_LEFT_Y, BOTTOM_RIGHT_Y))
			fire.z_index = 50 # make sure it's visible on top of our other items like the tilemap
			%Missions.add_child(fire)
			number_active_missions += 1
			mission_type = "Fire"
		elif Utility.selected_vehicle.vehicletype == vehicle_resource.vehicle_type.POLICECAR:
			pass
		elif Utility.selected_vehicle.vehicletype == vehicle_resource.vehicle_type.SCHOOLBUS:
			pass
		elif Utility.selected_vehicle.vehicletype == vehicle_resource.vehicle_type.TOWTRUCK:
			pass
	%Timer.start() # restart the timer

func fireOut(staticbody2d_id: int) -> void:
	# check to see which fire we should put out
	for mission in %Missions.get_children():
		if mission.fireOut(staticbody2d_id):
			number_active_missions -= 1
