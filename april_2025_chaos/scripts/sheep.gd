extends CharacterBody2D


@export var speed : int = 100
@export var player_avoid_radius : int = 80
@export var gather_radius : int = 60
@export var separation_radius : int = 55
@onready var player = GameManager.player
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var all_sheep : Array = []
@export var gather_strength : float = 0.5
var goal_reached : bool = false
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	all_sheep = get_parent().get_children()

func _process(delta: float) -> void:
	var move_vector : Vector2 = Vector2.ZERO
	animation_control()

	# Run from player 
	var distance_to_player = global_position - player.global_position
	var distance_to_player_length = distance_to_player.length()
	if distance_to_player_length < player_avoid_radius:
		move_vector += distance_to_player.normalized() * (1.0 - distance_to_player_length / player_avoid_radius ) * speed
	
		# Separate from other sheep
	for other_sheep in all_sheep:
		if other_sheep == self or not is_instance_valid(other_sheep):
			continue
		var offset = global_position - other_sheep.global_position
		var distance_from_sheep = offset.length()
		if distance_from_sheep < separation_radius:
			move_vector += offset.normalized() * (1.0 - distance_from_sheep / separation_radius) * speed
	
	
	# Gather together
	#var center_position : Vector2 = Vector2.ZERO
	#var nearby_sheep : int = 0
	
	#for sheep in all_sheep:
		#if sheep == self:
			#continue
		#var distance = global_position.distance_to(sheep.global_position)
		#if distance < gather_radius and distance > separation_radius:
			#center_position += sheep.global_position
			#nearby_sheep += 1
	#
	#if nearby_sheep > 0:
		#center_position /= nearby_sheep
		#var gather_direction = (center_position - global_position).normalized()
		#move_vector += gather_direction * gather_strength * speed



	if goal_reached == false:
		move_and_slide()
		velocity = move_vector

var direction : int 
func animation_control():
	if abs(velocity.x) > abs(velocity.y):
		if velocity.x < 0:
			animated_sprite_2d.play("left")
			direction = 1
		elif velocity.x > 0:
			animated_sprite_2d.play("right")
			direction = 2
	elif abs(velocity.y) > 0:
		if velocity.y < 0:
			animated_sprite_2d.play("up")
			direction = 3
		elif velocity.y > 0:
			animated_sprite_2d.play("down")
			direction = 4
	
	else:
		if direction == 1:
			animated_sprite_2d.play("left_idle")
		if direction == 2:
			animated_sprite_2d.play("right_idle")
		if direction == 3:
			animated_sprite_2d.play("up_idle")
		if direction == 4:
			animated_sprite_2d.play("down_idle")
func reached_goal():
	all_sheep.erase(self)
	goal_reached = true
	collision_shape_2d.call_deferred("set_disabled", true)

func die():
	all_sheep.erase(self)
	call_deferred("queue_free")
