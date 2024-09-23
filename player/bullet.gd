extends Area2D

var SPEED = 500

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta 

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("basic_ghost_enemy"):
		print("shot ghost")
		if body.has_method("take_damage"):
			body.take_damage(10)
			print("ghost took damage")
