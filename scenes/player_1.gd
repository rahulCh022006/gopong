extends CharacterBody2D


var accelerating_speed :int = 10
var speed: int
var decelerating_speed: float = 0.95
var screen_size: Vector2
var paddle_size: int = 128
var paddle_position_x: int
var start_velocity: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	start_velocity = velocity
	paddle_position_x = position.x

func _physics_process(delta: float) -> void:
	movement_()
	restrict_bounds()
	velocity = start_velocity
	position.x = paddle_position_x
	

func movement_() -> void:
	
	var Input_dir = Input.get_axis("Up_1","Down_1")
	
	if Input_dir != 0:
		speed = Input_dir * accelerating_speed
	else:
		speed *= decelerating_speed
	
	position.y += speed
	move_and_slide()

func restrict_bounds() -> void:
	#screen_size = get_viewport().size
	var screen_top = 0 + paddle_size/2
	var screen_bottom = screen_size.y - paddle_size/2
	position.y = clamp(position.y, screen_top, screen_bottom)
	
