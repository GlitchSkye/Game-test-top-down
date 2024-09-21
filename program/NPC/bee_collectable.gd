extends CharacterBody2D
@onready var player: CharacterBody2D = $"../playerCharacterBody2d"
@onready var ghost_basic_enemy: AnimatedSprite2D = $ghost_basic_enemy
@onready var game_manager: Node = %GameManager

#var speed = 100

func _physics_process(delta: float) -> void:
	#
	#var direction = (player.global_position - position).normalized()
#
	#velocity = direction * speed 

	move_and_slide()
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	ghost_basic_enemy.animation = "disappear"
	await ghost_basic_enemy.animation_finished
	queue_free() 
