extends Node

var player : CharacterBody2D
var current_checkpoint_position : Vector2

signal color_changed(color :ChameleonColour.Colour)

func set_checkpoint_position(target : Vector2):
	current_checkpoint_position = target 
	
func set_player(target : CharacterBody2D):
	player = target

func change_color(color : int):
	color_changed.emit(color)
