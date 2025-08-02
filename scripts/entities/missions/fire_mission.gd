extends Node2D


func _on_fire_out_timer_timeout() -> void:
	self.queue_free() # this also removes it from the scene

func _on_fire_out(staticbody2d_id: int) -> void:
	if %StaticBody2D.get_instance_id() == staticbody2d_id:
		%FireOutTimer.start()
