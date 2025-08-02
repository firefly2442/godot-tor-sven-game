extends Resource
class_name vehicle_resource

@export var speed: float ## the vehicle speed
@export var vehicletype: vehicle_type ## the type of vehicle
@export var texture: Texture2D ## image texture of vehicle
@export var vehicle_engine_sound: AudioStream ## the vehicle engine sound
@export var vehicle_horn_sound: AudioStream ## the vehicle horn sound

enum vehicle_type {
	AMBULANCE,
	FIRETRUCK,
	POLICECAR,
	SCHOOLBUS,
	TOWTRUCK
}
