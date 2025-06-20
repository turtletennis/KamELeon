extends Node

var player : CharacterBody2D
var fade : Fade 
var current_checkpoint_position : Vector2

signal color_changed(color :ChameleonColour.Colour)
signal level_complete()

func set_checkpoint_position(target : Vector2):
	current_checkpoint_position = target 
	
func set_player(target : CharacterBody2D):
	player = target

func complete_level():
	level_complete.emit()
	
func change_color(color : int):
	color_changed.emit(color)
