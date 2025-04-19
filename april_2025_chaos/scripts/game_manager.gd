extends Node


var player
var goblins : Array[Goblin]


var current_highest_level : int = 6

func set_player(target):
	player = target
	print(player)

func set_goblins(target):
	goblins = target

func set_highest_level(level : int):
	if level > current_highest_level:
		current_highest_level = level
