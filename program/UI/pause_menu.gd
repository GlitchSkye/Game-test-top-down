extends Control

@onready var node: Node = $".."
@onready var game_manager: Node = %GameManager


func _on_resume_pressed() -> void:
	game_manager.pauseMenu()
	
func _on_quit_pressed() -> void:
	get_tree().quit()
