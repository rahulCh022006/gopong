extends CharacterBody2D

var screen_size: Vector2
var ball_size: float = 32
var ball_speed = Vector2(250,250) # Initial speed and direction
var starting_position: Vector2
@onready var level_0: Node2D = $".."
@onready var goal_timer: Timer = $GoalTimer
@onready var collision_timer: Timer = $CollisionTimer
var can_collide : bool = true

func _ready() -> void:
	screen_size = get_viewport_rect().size
	velocity = Vector2(ball_speed)
	starting_position = position

func _physics_process(delta: float) -> void:
	restrict_bounds()
	check_jitters()
	move_and_slide()
	collisions_()

func restrict_bounds():
	
	
	screen_size = get_viewport_rect().size
	position.y = clamp(position.y, ball_size/2, screen_size.y - ball_size/2)
	
	#collision of ball with the top and bottom edges
	if position.y <= ball_size/2 || position.y >= screen_size.y - ball_size/2:
		velocity.y = -velocity.y

func collisions_():
	if get_slide_collision_count() > 0:
		var collision =  get_slide_collision(0)
		
		if collision.get_collider().is_in_group("Paddles") and can_collide:
			collision_timer.start()
			velocity = velocity.bounce(collision.get_normal()) * ball_speed
			#velocity = veball_speed
			velocity = clamp(velocity, -ball_speed, ball_speed)
			velocity.x = clamp(velocity.x, -ball_speed.x, ball_speed.x)
			velocity.y = clamp(velocity.y, -ball_speed.y, ball_speed.y)
			position += collision.get_normal() * ball_size/4
		#finding if the velocity in x direction after collision is less and giving a nudge
		if abs(velocity.x) < 50:
			velocity.x = ball_speed.x * sign(collision.get_normal().x)

func check_jitters():
	if collision_timer.is_stopped():
		can_collide = true
	else:
		can_collide = false
func reset_():
	goal_timer.start()

func _on_goal_timer_timeout() -> void:
	position = starting_position
