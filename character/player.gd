extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -500.0
const interaction = 24

@onready var pumpkin = $"Items/pumpkin"
@onready var pumpkin_spot = $"pumpkin_spot"

var holding = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		if not holding:
			if (global_position.distance_to(pumpkin.global_position) <= interaction):
				pumpkin.global_position = pumpkin_spot.global_position
		
