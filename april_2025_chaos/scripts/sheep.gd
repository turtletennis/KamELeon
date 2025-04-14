extends CharacterBody2D


@export var speed : int = 100
@export var player_avoid_radius : int = 80
@export var gather_radius : int = 60
@export var gather_strength : float = 0.2
@export var separation_radius : int = 55
@onready var player = GameManager.player
@export var obstacle_avoidance_radius : int = 300
@onready var all_sheep : Array = []
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var scary_obstacles = get_node("/root/level/scary_obstacles").get_children()
@onready var sound_effect_timer: Timer = $sound_effect_timer
@onready var sheep_baa_sound: AudioStreamPlayer2D = $sheep_baa_sound
@onready var fence_raycast = $fence_raycast

var conveyer_direction : String
var on_conveyer : bool 
var conveyer_speed : int
var goal_reached : bool = false


func _ready() -> void:
	all_sheep = get_parent().get_children()
	randomize_sound_timer()

func _physics_process(delta: float) -> void:
	var move_vector : Vector2 = Vector2.ZERO
	animation_control()
	conveyer_movement()
	
	# cast ray to avoid standing next to fence 
	fence_raycast.target_position = velocity.normalized() * 100
	fence_raycast.force_raycast_update()
	
	if fence_raycast.is_colliding():
		var collision_normal = fence_raycast.get_collision_normal()
		velocity += collision_normal * speed * 0.4
			
	# Run from player 
	var distance_to_player = global_position - player.global_position
	var distance_to_player_length = distance_to_player.length()
	if distance_to_player_length < player_avoid_radius:
		move_vector += distance_to_player.normalized() * (1.0 - distance_to_player_length / player_avoid_radius ) * speed
	
	#run from "scary obstacle"
	for obstacle in scary_obstacles:
		var offset = global_position - obstacle.global_position
		var distance_from_obstacle = offset.length()
		if distance_from_obstacle < obstacle_avoidance_radius:
			move_vector += offset.normalized() * (1.0 - distance_from_obstacle / obstacle_avoidance_radius) * speed
	
	
		# Separate from other sheep
	for other_sheep in all_sheep:
		if other_sheep == self or not is_instance_valid(other_sheep):
			continue
		var offset = global_position - other_sheep.global_position
		var distance_from_sheep = offset.length()
		if distance_from_sheep < separation_radius:
			move_vector += offset.normalized() * (1.0 - distance_from_sheep / separation_radius) * speed
	
	
	#Gather together
	#var center_position : Vector2 = Vector2.ZERO
	#var nearby_sheep : int = 0
	#
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
		#var to_center = center_position - global_position
		#if to_center.length() > 100: 
			#var gather_direction = to_center.normalized()
			#move_vector += gather_direction * gather_strength * (speed/2)



	if goal_reached == false:
		velocity = move_vector
		move_and_slide()
		
var direction : int 

func animation_control():
	
	

	if abs(velocity.x) > abs(velocity.y):
		if velocity.x < 0:
			animated_sprite_2d.play("left")
			direction = 1
		elif velocity.x > 0 :
			animated_sprite_2d.play("right")
			direction = 2
	else:
		if velocity.y < 0 :
			animated_sprite_2d.play("up")
			direction = 3
		elif velocity.y > 0 :
			animated_sprite_2d.play("down")
			direction = 4
	match direction:
		1:
			animated_sprite_2d.play("left_idle")
		2:
			animated_sprite_2d.play("right_idle")
		3:
			animated_sprite_2d.play("up_idle")
		4:
			animated_sprite_2d.play("down_idle")
func reached_goal():
	all_sheep.erase(self)
	goal_reached = true
	collision_shape_2d.call_deferred("set_disabled", true)
func die():
	all_sheep.erase(self)
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
			velocity.y = -conveyer_speed
		if conveyer_direction == "down":
			velocity.y = conveyer_speed
		if conveyer_direction == "left":
			velocity.x = -conveyer_speed
		if conveyer_direction == "right":
			velocity.x = conveyer_speed
func randomize_sound_timer():
	var random_time = randi_range(8, 20)
	sound_effect_timer.wait_time = random_time
	sound_effect_timer.start()

func _on_sound_effect_timer_timeout() -> void:
	var sound_effect_chance = randi_range(0,1)
	if sound_effect_chance == 0:
		var random_pitch = randf_range(0.9, 1.1)
		sheep_baa_sound.pitch_scale = random_pitch
		sheep_baa_sound.play()
		randomize_sound_timer()
	else:
		randomize_sound_timer()
		
