extends Node



func spawn_particle_burst(position: Vector2, texture: Texture2D, count: int = 5) -> void:
	var particles: CPUParticles2D = CPUParticles2D.new()
	particles.texture = texture
	particles.position = position
	particles.amount = count

	particles.lifetime = 3.5
	particles.one_shot = true
	particles.explosiveness = 1.0  # Instant burst
	particles.gravity = Vector2.ZERO
	particles.emitting = true

	# Configure random velocity burst
	particles.initial_velocity_min = 100.0
	particles.initial_velocity_max = 200.0
	particles.direction = Vector2(0, -1)
	particles.spread = 180.0  # Full circle

	add_child(particles)

	await get_tree().create_timer(particles.lifetime).timeout
	particles.queue_free()
