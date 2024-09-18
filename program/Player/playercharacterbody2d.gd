extends CharacterBody2D

const SPEED = 300.0
const DASH_SPEED = 600.0
const DASH_DURATION = 0.2
const DASH_COOLDOWN = 1.0
const DECELERATION = 10.0
var is_dashing = false
var dash_time = 0.0
var dash_cooldown_time = 0.0

var mouse_position = Vector2()

@onready var player: AnimatedSprite2D = $player
@onready var bee_collectable: CharacterBody2D = $bee_collectable # Corrected node path reference
@onready var game_manager: Node = %GameManager
@onready var sword: Area2D = $"../weapon/sword"

func _physics_process(delta: float) -> void:
	# Handle Dash cooldown
	if dash_cooldown_time > 0:
		dash_cooldown_time -= delta

	# Handle dash timing
	if is_dashing:
		dash_time -= delta
		if dash_time <= 0:
			is_dashing = false  # End the dash

	# Animations for walking
	if abs(velocity.x) > 1:
		player.animation = "run"
	else:
		player.animation = "idle"

	# Get the input direction and handle the movement/deceleration
	var direction := Input.get_axis("ui_left", "ui_right")
	
	# Check for Dash input (Shift key or custom dash action)
	if Input.is_action_just_pressed("ui_dash") and not is_dashing and dash_cooldown_time <= 0:
		is_dashing = true
		dash_time = DASH_DURATION
		dash_cooldown_time = DASH_COOLDOWN
	
	if is_dashing:
		velocity.x = direction * DASH_SPEED
	else:
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, DECELERATION)

	var directionY = Input.get_axis("ui_up", "ui_down")
	if directionY != 0: 
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, DECELERATION)
		
	# Apply velocity to character
	move_and_slide()
	
	# Facing correct direction
	player.flip_h = velocity.x < 0
	
func _process(delta):
	pass
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bee_collectable"):
		print("collided with bee")
		game_manager.add_points(1)
