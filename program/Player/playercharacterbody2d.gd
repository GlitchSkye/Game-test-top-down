extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var mouse_position = Vector2()

@onready var player: AnimatedSprite2D = $player
@onready var bee_collectable: CharacterBody2D = $"."
@onready var game_manager: Node = %GameManager
@onready var sword: Area2D = $"../weapon/sword"

func _physics_process(delta: float) -> void:
	
	#animations for walking
	if (velocity.x > 1 || velocity.x < -1):
		player.animation = "run"
	else:
		player.animation = "idle"

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)

	var directionY = Input.get_axis("ui_up", "ui_down")
	if directionY: 
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, 10)
	move_and_slide()
	
	#facing correct way
	var isLeft = velocity.x < 0
	player.flip_h = isLeft
	
func _process(delta):

	mouse_position = get_viewport().get_mouse_position()

	var sword_global_position = sword.global_position

	var direction = (mouse_position - sword_global_position).normalized()

	sword.rotation = direction.angle()
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bee_collectable"):
		print("collided w bee")
		game_manager.add_points(1)
