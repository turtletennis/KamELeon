extends CharacterBody2D


@export var speed : int = 100
@export var player_avoid_radius : int = 100
@export var gather_radius : int = 60
@onready var player = GameManager.player
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var all_sheep : Array = []
@export var gather_strength : float = 0.5

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
	
	# Gather together
	var center_position : Vector2 = Vector2.ZERO
	var nearby_sheep : int = 0
	
	for sheep in all_sheep:
		if sheep == self:
			continue
		var distance = global_position.distance_to(sheep.global_position)
		if distance < gather_radius:
			center_position += sheep.global_position
			nearby_sheep += 1
	
	if nearby_sheep > 0:
		center_position /= nearby_sheep
		var gather_direction = (center_position - global_position).normalized()
		move_vector += gather_direction * gather_strength * speed



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

func run_from_player():
	pass
