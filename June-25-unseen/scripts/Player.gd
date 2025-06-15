class_name Player
extends CharacterBody2D


@export var movement_speed : int = 100
@export var air_movement_speed : int = 100
@export var acceleration : int = 1000
@export var decceleration : int = 1000
@export var jump_power : int = 200
@export var jump_gravity : int = 600
@export var fall_gravity : int = 600
@export var max_fall_speed : int = 1200
@export var wall_slide_speed : int = 40
@export var wall_friction : int = 2000
@export var wall_jump_power : int = 200


@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var right_ray_cast_1: RayCast2D = $right_ray_cast_1
@onready var right_ray_cast_2: RayCast2D = $right_ray_cast_2
@onready var left_ray_cast_1: RayCast2D = $left_ray_cast_1
@onready var left_ray_cast_2: RayCast2D = $left_ray_cast_2
@onready var coyotee_timer: Timer = $coyotee_timer

var on_left_wall : bool
var on_right_wall : bool
var on_any_wall : bool
var coyotee_time_active : bool 
var double_jump_available : bool 

func _ready() -> void:
	GameManager.set_player(self)

func _physics_process(delta: float) -> void:
	on_left_wall = left_ray_cast_1.is_colliding() and left_ray_cast_2.is_colliding()
	on_right_wall = right_ray_cast_1.is_colliding() and right_ray_cast_2.is_colliding()
	on_any_wall = on_left_wall or on_right_wall
	move_and_slide()
	if is_on_floor():
		double_jump_available = true
	
func die():
	pass


func coyotee_time():
	coyotee_time_active = true
	coyotee_timer.start()

func _on_coyotee_timer_timeout() -> void:
	coyotee_time_active = false


## colors,0 = normal,  1 = blue, 2 = pink 
var current_color = 0


func _on_blue_pressed() -> void:
	current_color = 1

func _on_pink_pressed() -> void:
	current_color = 2

func _on_normal_pressed() -> void:
	current_color = 0
