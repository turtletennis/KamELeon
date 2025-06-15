class_name PlayerState
extends Node

#####################################
# This is the base enemy state
# Each state will inherit from this
#####################################

signal transitioned(state: PlayerState, new_state_name: String)

@onready var player : Player = get_owner()
var direction : float
var wall_direction : bool

func _physics_process(delta: float) -> void:
	# setting input direction
	direction = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	# flipping sprite toward direction its moving
	
	if player.velocity.x > 0 :
		player.animation.flip_h = false
	if player.velocity.x < 0 :
		player.animation.flip_h = true
	
	# getting wall direction
	if player.on_any_wall and !player.is_on_floor():
		wall_direction = player.get_wall_normal().x < 0
		player.animation.flip_h = wall_direction
	
func _ready():
	pass


# This is called directly when transitioning to this state
# Useful for setting up the state to be used
# In Idle, we use this function to decide how long we will idle for
func enter():
	pass


# When the state is active, this is essentially the _process() function
func process_state(delta: float):
	pass


# When the state is active, this is essentially the _physics_process() function
func physics_process_state(delta: float):
	pass


# Useful for cleaning up the state
# For example, clearing any timers, disconnecting any signals, etc.
func exit():
	pass


###############################################
# Non FSM-specific methods. These are utility 
# methods that may be used by multiple states. 
###############################################
