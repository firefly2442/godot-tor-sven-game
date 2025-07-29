extends Resource
class_name vehicle_resource

@export var speed: float ## the vehicle speed
@export var vehicletype: vehicle_type ## the type of vehicle
@export var texture: Texture2D ## image texture of vehicle

enum vehicle_type {
	AMBULANCE,
	FIRETRUCK,
	POLICECAR,
	SCHOOLBUS,
	TOWTRUCK
}
