extends CharacterBody2D

# Constants for movement and dash behavior
const SPEED = 300.0
const DASH_SPEED = 1200.0
const DASH_DURATION = 0.5
const DASH_COOLDOWN = 1.0
const DECELERATION = 10.0

# Animation states as constants to avoid typos
const IDLE_ANIMATION = "idle"
const RUN_ANIMATION = "run"
const DASH_ANIMATION = "dash"

# Variables for dash control
var is_dashing = false
var dash_time = 0.0
var dash_cooldown_time = 0.0  # Initialize cooldown time to 0
var dash_direction = Vector2.ZERO  # Store the direction of the dash
var has_dashed = false  # Flag to track if the dash has been used

var mouse_position = Vector2()

@onready var player: AnimatedSprite2D = $player
@onready var bee_collectable: CharacterBody2D = $bee_collectable
@onready var game_manager: Node = %GameManager
@onready var sword: Area2D = $"../weapon/sword"

func _physics_process(delta: float) -> void:
	# Handle dash cooldown
	if dash_cooldown_time > 0:
		dash_cooldown_time -= delta
	
	# Update dash state
	if is_dashing:
		update_dash(delta)
	else:
		handle_movement(delta)
	
	# Apply velocity to the character
	move_and_slide()  # No arguments needed, `velocity` is already part of the character
	
	# Set player flip based on movement direction
	player.flip_h = velocity.x < 0

# Function to handle basic movement
func handle_movement(delta: float) -> void:
	var direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))

	# Start dash if the dash input is pressed
	if Input.is_action_just_pressed("ui_dash") and (not has_dashed or dash_cooldown_time <= 0):
		start_dash(direction)
		return
	
	# Handle normal movement when not dashing
	if direction != Vector2.ZERO:
		velocity = direction.normalized() * SPEED
		set_animation(RUN_ANIMATION)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
		velocity.y = move_toward(velocity.y, 0, DECELERATION)
		set_animation(IDLE_ANIMATION)

# Function to start dash
func start_dash(direction: Vector2) -> void:
	if direction != Vector2.ZERO:
		is_dashing = true
		dash_time = DASH_DURATION
		dash_direction = direction.normalized()  # Lock direction for the duration of the dash
		set_animation(DASH_ANIMATION)
		if has_dashed:
			dash_cooldown_time = DASH_COOLDOWN  # Set cooldown after the first dash
		else:
			has_dashed = true  # Indicate that the dash has been used

# Function to update dash logic
func update_dash(delta: float) -> void:
	dash_time -= delta
	if dash_time <= 0:
		is_dashing = false  # End the dash
		# Optionally set to idle or run animation after dash ends
	else:
		velocity = dash_direction * DASH_SPEED  # Maintain the locked dash direction

# Helper function to set animations
func set_animation(animation_name: String) -> void:
	if player.animation != animation_name:
		player.animation = animation_name

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bee_collectable"):
		print("collided with bee")
		game_manager.add_points(1)
