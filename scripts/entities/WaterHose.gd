extends Node2D


func _ready() -> void:
	$GPUParticles2D.emitting = false


func _physics_process(_delta: float) -> void:
	if %RayCast2D.is_colliding():
		var hit_pos: Vector2 = %RayCast2D.get_collision_point()
		print_debug(hit_pos)

func _process(_delta: float) -> void:
	var hose_direction: Vector2 = Vector2.ZERO
	if Utility.player1_selected == "Operator":
		hose_direction = Input.get_vector("left_p1", "right_p1", "up_p1", "down_p1")
	elif Utility.player2_selected == "Operator":
		hose_direction = Input.get_vector("left_p2", "right_p2", "up_p2", "down_p2")

	if hose_direction.length_squared() > 0.0001:
		# Set rotation so local +X points toward input direction.
		rotation = hose_direction.angle()

func _unhandled_input(_event: InputEvent) -> void:
	if Utility.player1_selected == "Operator" and Input.is_action_just_pressed("action_p1") or \
		Utility.player2_selected == "Operator" and Input.is_action_just_pressed("action_p2"):
		if $GPUParticles2D.emitting:
			$GPUParticles2D.emitting = false
			%RayCast2D.enabled = false
		else:
			$GPUParticles2D.emitting = true
			%RayCast2D.enabled = true
