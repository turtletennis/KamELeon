class_name PlayerController
extends CharacterBody2D


@export var movement_speed : int = 100
@export var air_movement_speed : int = 100
@export var acceleration : int = 1000
@export var decceleration : int = 1000
@export var jump_power : int = 800
@export var jump_gravity : int = 600
@export var fall_gravity : int = 600
@export var max_fall_speed : int = 1200
@export var wall_slide_speed : int = 40
@export var wall_friction : int = 2000
@export var wall_jump_power : int = 200
@export var time_to_respawn : int = 4


@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var right_ray_cast_1: RayCast2D = $right_ray_cast_1
@onready var right_ray_cast_2: RayCast2D = $right_ray_cast_2
@onready var left_ray_cast_1: RayCast2D = $left_ray_cast_1
@onready var left_ray_cast_2: RayCast2D = $left_ray_cast_2
@onready var coyotee_timer: Timer = $coyotee_timer
@onready var death_particles: GPUParticles2D = $death_particles
@onready var death_sfx_player: AudioStreamPlayer = $death_AudioStreamPlayer
@onready var jump_sfx_player: AudioStreamPlayer = $jump_AudioStreamPlayer
@onready var double_jump_sfx_player: AudioStreamPlayer = $double_jump_AudioStreamPlayer
@onready var wall_jump_sfx_player: AudioStreamPlayer = $wall_jumpAudioStreamPlayer
@onready var state_machine:StateMachine = $state_machine
@onready var sprite:SpriteColourChanger = $AnimatedSprite2D
var on_left_wall : bool
var on_right_wall : bool
var on_any_wall : bool
var coyotee_time_active : bool 
var double_jump_available : bool

func _ready() -> void:
	GameManager.set_player(self)
	GameManager.color_changed.connect(change_color)
	change_color(ChameleonColour.Colour.NORMAL)
	

func _physics_process(_delta: float) -> void:
	on_left_wall = left_ray_cast_1.is_colliding() and left_ray_cast_2.is_colliding()
	on_right_wall = right_ray_cast_1.is_colliding() and right_ray_cast_2.is_colliding()
	on_any_wall = on_left_wall or on_right_wall
	move_and_slide()
	if is_on_floor():
		double_jump_available = true
	
func die():
	state_machine.on_child_transition(state_machine.current_state, "dead")

func level_complete():
	state_machine.on_child_transition(state_machine.current_state,"cutscene")
func respawn():
	global_position = GameManager.current_checkpoint_position
	GameManager.fade.fadeFromBlack()

func coyotee_time():
	coyotee_time_active = true
	coyotee_timer.start()

func _on_coyotee_timer_timeout() -> void:
	coyotee_time_active = false


var current_color = ChameleonColour.Colour.NORMAL

func change_color(color_index:ChameleonColour.Colour):
	current_color = color_index
	print_debug("player colour changing to ",color_index)
	sprite.setColour(color_index)

func _on_spikes_body_entered(body:Node2D) -> void:
	if body.is_in_group("player"):
		body.die()
