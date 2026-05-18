extends CharacterBody2D
class_name Player

@export var potions: Node

@export var speed 		 : float = 300.0
@export var jump_velocity: float = -400.0

@export var jump_power: float = 1
@export var speed_power: float = 1

var can_jump: bool = false

func _physics_process(delta_t: float) -> void:
	move(delta_t)

func move(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		can_jump = true

	# Handle jump.
	if Input.is_action_pressed("jump") and can_jump:
		can_jump = false
		velocity.y = jump_velocity * jump_power

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_power
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.3)

	move_and_slide()
