extends CharacterBody2D


@export var speed : int = 60
@export var separation_radius : int = 55

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

var in_detection : bool 
var goal_reached : bool = false
var navigation_distance_buffer : int = 50
var navigating : bool = false

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var move_vector: Vector2 = Vector2.ZERO
	animation_control()

	# stop navigating when reached destination
	if navigation_agent_2d.is_navigation_finished():
		navigating = false
	else:
		var next_path_point = navigation_agent_2d.get_next_path_position()
		var distance_to_point = global_position.distance_to(next_path_point)

		if distance_to_point > navigation_distance_buffer:
			navigating = true

		if navigating:
			var direction = (next_path_point - global_position).normalized()
			position += direction * speed * delta

	# avoid other goblins once nav has stopped

	
	move_and_slide()
	velocity = move_vector
		
		
var last_position: Vector2
var direction = 4  # Default facing down

func animation_control():
	var movement = global_position - last_position
	var moving = movement.length() > 0.1  

	if moving:
		if abs(movement.x) > abs(movement.y):
			if movement.x < 0:
				animated_sprite_2d.play("left")
				direction = 1
			else:
				animated_sprite_2d.play("right")
				direction = 2
		else:
			if movement.y < 0:
				animated_sprite_2d.play("up")
				direction = 3
			else:
				animated_sprite_2d.play("down")
				direction = 4
	else:
		match direction:
			1: animated_sprite_2d.play("left_idle")
			2: animated_sprite_2d.play("right_idle")
			3: animated_sprite_2d.play("up_idle")
			4: animated_sprite_2d.play("down_idle")

	last_position = global_position
func reached_goal():
	goal_reached = true

func die():
	queue_free.call_deferred()
	
func enter_detection():
	in_detection = true
func exit_detection():
	in_detection = false
	
func add_point(position):
	navigation_agent_2d.target_position = get_global_mouse_position()
	
