extends Area2D
class_name Sword 

var mouse_position = Vector2()
@export var rotation_speed: float = 5.0  # Adjust this value to control how fast the sword rotates

var weapon: Node2D = null  # Reference to the Weapon node
var player: Node2D = null  # Reference to the Player node

func _ready():
	# Ensure you have references to the Weapon and Player nodes
	weapon = get_parent()  # Weapon is the parent of Sword
	player = weapon.get_parent()  # Player is the parent of Weapon

func _process(delta):
	if not weapon:
		return

	# Get the global mouse position
	var mouse_position =get_global_mouse_position()

	# Calculate the direction from the sword to the mouse position in global space
	var direction = (mouse_position - global_position).normalized()
	
	# Calculate the target angle
	var target_angle = direction.angle()
	
	# Set the sword's rotation directly to the target angle
	rotation = target_angle
