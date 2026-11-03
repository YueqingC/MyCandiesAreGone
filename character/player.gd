extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -500.0
const interaction = 50

var holding = -1
var placed = [false, false, false, false]

@onready var items = [
	$"../Items/pumpkin",
	$"../Items/lamp",
	$"../Items/candyJar",
	$"../Items/flags"
	]
@onready var spots = [
	$"../SnapPoints/pumpkin_spot",
	$"../SnapPoints/lamp_spot",
	$"../SnapPoints/candyJar_spot",
	$"../SnapPoints/flags_spot",
]

@onready var flags_interact_spot = $"../SnapPoints/flags_interact_spot"
@onready var candyJar_interact_spot = $"../SnapPoints/canyJar_interact_spot"
@onready var pumpkin_interact_spot = $"../SnapPoints/pumpkin_interact_spot"

@onready var pumpkinHint = $"../pumpkinHint"
@onready var candyJarHint = $"../candyJarHint"
@onready var flagsHint = $"../flagsHint"

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
	if global_position.x <= 0:
		global_position.x = 0
	elif global_position.x >= 2320:
		global_position.x = 2320
	
	
	pumpkinHint.visible = (holding == 0)
	candyJarHint.visible = (holding == 2)
	flagsHint.visible = (holding == 3)
	
	if holding != -1:
		items[holding].global_position = global_position + Vector2(0, -24)
		
	if Input.is_action_just_pressed("interact"):
		print("e")
		if holding == -1:
			for i in range(items.size()):
				if not placed[i]:
					if global_position.distance_to(items[i].global_position) <= interaction:
						holding = i
						items[i].z_index = 2
						print("Picked up: ", items[i].name)
						break
		else:
			var target = spots[holding].global_position
			print("Currently holding pumpkin!")
			if holding == 0:
				print("true")
				target = pumpkin_interact_spot.global_position
			if holding == 1:
				print("true")
				target = candyJar_interact_spot.global_position
			if holding == 3:
				print("true")
				target = flags_interact_spot.global_position
				
			if (global_position.distance_to(target) <= interaction):
				items[holding].global_position = spots[holding].global_position
				if holding == 3:
					items[holding].scale = Vector2(0.767, 0.576)
				items[holding].z_index = 0
				placed[holding] = true
				print("Placed")
				pumpkinHint.visible = false
				candyJarHint.visible = false
				flagsHint.visible = false
				holding = -1
			else:
				print("too far")
				
func _ready():
	pumpkinHint.visible = false
	candyJarHint.visible = false
	flagsHint.visible = false
	print("Flags interaction point: ", flags_interact_spot)
	for i in range(items.size()):
		print("Item ", i, ": ", items[i])
		print("Spot ", i, ": ", spots[i])
