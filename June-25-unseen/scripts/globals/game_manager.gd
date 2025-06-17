extends Node

var player : CharacterBody2D
var current_checkpoint_position

func set_checkpoint_position(target):
	current_checkpoint_position = target 
	
func set_player(target):
	player = target
