extends CharacterBody2D
class_name Player

@export var potions: Node
@export var animated_sprite: AnimatedSprite2D

@export var debbug_label: Label

@export var speed 		 : float = 300.0
@export var jump_velocity: float = -400.0

@export var jump_power: float = 1
@export var speed_power: float = 1

@export var float_minimum: float = 1

var can_jump: bool = false

func _physics_process(delta_t: float) -> void:
	move(delta_t)
	animation()
	debbug_update()

func debbug_update() -> void:
	debbug_label.text = "  Velocity: " + str(velocity.x) + ", " + str(velocity.y)

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
		velocity.x = 0

	move_and_slide()


func animation() -> void:

	if velocity.x < 0.1 and velocity.x > -0.1:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("side")

	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true
