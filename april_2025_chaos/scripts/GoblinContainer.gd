class_name GoblinContainer extends Node

var goblins : Array[Goblin] = []

func _ready() -> void:
	var children = get_children()
	for child in children:
		if child is Goblin:
			goblins.append(child)
	
	GameManager.set_goblins(self)
	 

func findGoblinCanMoveClosestToPosition(positionToFind: Vector2) -> Goblin:
	var closest : Goblin = null
	var toFind = goblins.duplicate(false)
	
	
	
	var sortFunc := func(gob1:Goblin, gob2: Goblin) -> bool:
		var gob1Distance = gob1.global_position.distance_squared_to(positionToFind)
		var gob2Distance = gob2.global_position.distance_squared_to(positionToFind)
		return gob1Distance < gob2Distance
	toFind.sort_custom(sortFunc)
		
	return toFind.front()
		
