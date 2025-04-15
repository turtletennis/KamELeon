extends CharacterBody2D


@export var speed : int = 60
@export var separation_radius : int = 55
@onready var player = GameManager.player
@onready var all_goblins : Array = []
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D



var in_detection : bool 
var conveyer_direction : String
var on_conveyer : bool 
var conveyer_speed : int
var goal_reached : bool = false
var navigation_distance_buffer : int = 50
var navigating : bool = false

func _ready() -> void:
	all_goblins = get_parent().get_children()

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

	# avoid other goblins
	if navigation_agent_2d.is_navigation_finished():
		for other_goblins in all_goblins:
			if other_goblins == self or not is_instance_valid(other_goblins):
				continue
			var offset = global_position - other_goblins.global_position
			var distance_from_goblins = offset.length()
			if distance_from_goblins < separation_radius:
				move_vector += offset.normalized() * (1.0 - distance_from_goblins / separation_radius) * speed
		position += move_vector * delta

	
	if goal_reached == false:
		move_and_slide()
		velocity = move_vector
		
		
var last_position: Vector2
var direction = 4  # Default facing down

func animation_control():
	var movement = global_position - last_position
	var moving = movement.length() > 0.1  # Tiny threshold to avoid flicker

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
	all_goblins.erase(self)
	goal_reached = true
	collision_shape_2d.call_deferred("set_disabled", true)
func die():
	all_goblins.erase(self)
	call_deferred("queue_free")
func entered_conveyer(direction, speed):
	on_conveyer = true
	conveyer_speed = speed
	conveyer_direction = direction
func exited_conveyer():
	on_conveyer = false
func conveyer_movement():
	if on_conveyer:
		if conveyer_direction == "up":
			velocity.y += -conveyer_speed
		if conveyer_direction == "down":
			velocity.y += conveyer_speed
		if conveyer_direction == "left":
			velocity.x += -conveyer_speed
		if conveyer_direction == "right":
			velocity.x += conveyer_speed
func enter_detection():
	in_detection = true
func exit_detection():
	in_detection = false
func add_point(position):
	navigation_agent_2d.target_position = get_global_mouse_position()
	
