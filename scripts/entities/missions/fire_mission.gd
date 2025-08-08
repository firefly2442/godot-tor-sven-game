extends Node2D

# the global positions range across the city for random fire mission generation
var TOP_LEFT_X: int = -1022
var TOP_LEFT_Y: int = -307
var BOTTOM_RIGHT_X: int = 1645
var BOTTOM_RIGHT_Y: int = 1337

var marked_removal: bool = false

func _ready() -> void:
	self.z_index = 50 # make sure it's visible on top of our other items like the tilemap
	self.global_position = Vector2i(randi_range(TOP_LEFT_X, BOTTOM_RIGHT_X), randi_range(TOP_LEFT_Y, BOTTOM_RIGHT_Y))

func _on_fire_out_timer_timeout() -> void:
	self.queue_free() # this also removes it from the scene

func fireOut(staticbody2d_id: int) -> bool:
	if %StaticBody2D.get_instance_id() == staticbody2d_id:
		# give it a few seconds to continue as a separate timer, otherwise
		# the fire goes out immediately after the ray intersection
		%SprayingWaterTimer.start()
		if not marked_removal:
			AudioManager.playSuccess()
			marked_removal = true
			return true
		else:
			return false
	else:
		return false

func _on_spraying_water_timer_timeout() -> void:
	%FireGPUParticles2D.emitting = false
	%SmokeGPUParticles2D.emitting = false
	%FireOutTimer.start()
