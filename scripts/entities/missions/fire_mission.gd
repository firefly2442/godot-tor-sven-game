extends Node2D

var marked_removal: bool = false

func _on_fire_out_timer_timeout() -> void:
	self.queue_free() # this also removes it from the scene

func fireOut(staticbody2d_id: int) -> bool:
	if %StaticBody2D.get_instance_id() == staticbody2d_id:
		# give it a few seconds to continue as a separate timer, otherwise
		# the fire goes out immediately after the ray intersection
		%SprayingWaterTimer.start()
		if not marked_removal:
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
