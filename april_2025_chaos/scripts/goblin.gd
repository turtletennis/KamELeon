class_name Goblin extends CharacterBody2D


@export var speed : float = 60.0
@export var separation_radius : float = 55.0

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

var stateMachine: GoblinStateMachine

var navigating : bool = false


func _ready() -> void:
	stateMachine = GoblinStateMachine.new(self)
	navigation_agent_2d.max_speed = speed
	navigation_agent_2d.radius = separation_radius
	
func _physics_process(delta: float) -> void:
	var next_path_point = navigation_agent_2d.get_next_path_position()
	if navigating:
		velocity = (next_path_point-global_position).normalized() * speed
		move_and_slide()
		animation_control()
		navigation_agent_2d.velocity = velocity

func on_avoid_calc(safe_Velocity : Vector2) -> void:
	if !safe_Velocity.length_squared() < 0.1:
		velocity = safe_Velocity
		# avoid other goblins once nav has stopped	
		move_and_slide()
		animation_control()
		navigation_agent_2d.velocity = velocity



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

func die():
	queue_free()

func add_point(targetPosition:Vector2):
	var scatterTarget = Vector2(randf_range(-separation_radius, separation_radius), randf_range(-separation_radius, separation_radius))
	
	navigation_agent_2d.target_position = targetPosition + scatterTarget
	navigating = true
	animated_sprite_2d.self_modulate = Color.RED
	navigation_agent_2d.avoidance_priority = randf_range(0.7, 1.0)


func _on_navigation_agent_2d_navigation_finished() -> void:
	navigating = false
	animated_sprite_2d.self_modulate = Color.BLUE
	navigation_agent_2d.avoidance_priority = randf_range(0.1, 0.3)
