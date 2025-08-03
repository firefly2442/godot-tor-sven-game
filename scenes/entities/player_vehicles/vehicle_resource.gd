extends Resource
class_name vehicle_resource

@export var speed: float ## the vehicle speed
@export var vehicletype: vehicle_type ## the type of vehicle
@export var texture: Texture2D ## image texture of vehicle
@export var vehicle_engine_sound: AudioStream ## the vehicle engine sound
@export var vehicle_horn_sound: AudioStream ## the vehicle horn sound
@export var operator_sound_back: AudioStream ## the operator controlled sound via back button
@export var vehicle_equipment: PackedScene ## the operator controlled equipment

enum vehicle_type {
	AMBULANCE,
	FIRETRUCK,
	POLICECAR,
	SCHOOLBUS,
	TOWTRUCK
}
