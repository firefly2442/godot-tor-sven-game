extends Node2D

@export var max_emission_rate: float = 400.0
@export var min_emission_rate: float = 50.0
@export var pressure: float = 1.0 # 0..1
@export var splash_scene: PackedScene  # assign a splash particle scene
@export var impact_distance: float = 800.0


func _ready() -> void:
	$RayCast2D.target_position = Vector2(impact_distance, 0)
	update_emission()

func set_pressure(p: float) -> void:
	pressure = clamp(p, 0.0, 1.0)
	update_emission()

func update_emission() -> void:
	# scale emission rate and particle speed with pressure
	#var material: ParticleProcessMaterial = stream.process_material
	#stream.emission_rate = lerp(min_emission_rate, max_emission_rate, pressure)
	#material.initial_velocity = lerp(200, 800, pressure)
	# optionally scale size/intensity
	#stream.scale = lerp(0.6, 1.2, pressure)
	pass

func _physics_process(_delta: float) -> void:
	# point the ray in hose direction
	#ray.cast_to = Vector2(impact_distance, 0).rotated(global_rotation)
	#ray.force_raycast_update()
	#if ray.is_colliding():
		#var hit_pos = ray.get_collision_point()
		#spawn_splash(hit_pos)
	pass

func _process(_delta: float) -> void:
	var hose_direction: Vector2 = Vector2.ZERO
	if Utility.player1_selected == "Operator":
		hose_direction = Input.get_vector("left_p1", "right_p1", "up_p1", "down_p1")
	elif Utility.player2_selected == "Operator":
		hose_direction = Input.get_vector("left_p2", "right_p2", "up_p2", "down_p2")

	if hose_direction.length_squared() > 0.0001:
		# Set rotation so local +X points toward input direction.
		rotation = hose_direction.angle()
