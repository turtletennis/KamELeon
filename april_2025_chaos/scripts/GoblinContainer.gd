extends Node

func _ready() -> void:
	
	var goblins : Array[Goblin] = []
	
	var children = get_children()
	for child in children:
		if child is Goblin:
			goblins.append(child)
	
	GameManager.set_goblins(goblins)
