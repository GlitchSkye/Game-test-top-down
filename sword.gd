extends Area2D
class_name sword


var mouse_position = Vector2()

func _process(delta):
	# Get the mouse position in the viewport
	mouse_position = get_viewport().get_mouse_position()

	# Calculate the direction from the sword to the mouse
	var direction = (mouse_position - global_position).normalized()
	
	# Rotate sword to face the mouse
	rotation = direction.angle()
