extends Node
@onready var points: Label = $"../CanvasLayer/score/points"
@onready var pause_menu: Control = $"../PauseMenu"

var paused = false
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		pauseMenu()

func pauseMenu():
	if paused: 
		pause_menu.hide()
		Engine.time_scale = 1
	else: 
		pause_menu.show()
		Engine.time_scale = 0
	#TODO: replace this with get_tree().pause 
	paused = !paused
		
func add_points(addition: int):
	score += addition
	print(score)
	points.text = str("Bees: ", score)

func spawn_random(amount: int): #for spawning random characterbody2D
	pass
