extends Node2D

var is_paused : bool 
var left_score : int = 0
var right_score : int = 0
var left_goal: bool
var right_goal: bool
@onready var ball: CharacterBody2D = $Ball
@onready var pink_score: Label = $ScoreArea/PinkScore
@onready var green_score: Label = $ScoreArea/GreenScore
@onready var basic_ui: Control = $BasicUI



func _ready() -> void:
	
	basic_ui.visible = false
	is_paused = false
	left_goal = false
	right_goal = false
func _physics_process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	#handles pause function of the game
	if event.is_action_pressed("Pause"):
		pause_()
	if event.is_action_pressed("Restart"):
		get_tree().reload_current_scene()

func add_score_():
	if right_goal:
		left_score += 1
		pink_score.text = "Pink Score : " + str(left_score)
		right_goal = false
	elif left_goal:
		right_score += 1
		green_score.text = "Green Score : " + str(right_score)
		left_goal = false

func goal_reset_():
	ball.reset_()
	
func pause_():
		is_paused = !is_paused
		basic_ui.visible = is_paused
		get_tree().paused = is_paused

func _on_goal_l_body_entered(body: Node2D) -> void:
	left_goal = true
	add_score_()
	goal_reset_()
	
func _on_goal_r_body_entered(body: Node2D) -> void:
	right_goal = true
	add_score_()
	goal_reset_()


func _on_play_pressed() -> void:
	pause_()


func _on_restart_pressed() -> void:
	pause_()
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()
