class_name GoblinContainer extends Node2D

@export var collector : CollectionPoint

var goblins : Array[Goblin] = []

func _ready() -> void:
	var children = get_children()
	for child in children:
		if child is Goblin:
			goblins.append(child)
	
	GameManager.set_goblins(self)
	 
func goblin_died(goblin: Goblin):
	if goblin.heldItem:
		collector.book_destroyed()
	goblins.erase(goblin)
	if goblins.is_empty():
		get_parent().failed_level()
		
	
	
func findGoblinCanMoveClosestToPosition(waypoint: WaypointMarker) -> Goblin:
	var closest : Goblin = null
	if goblins.is_empty():
		return
	var toFind = goblins.filter(func(gobbo: Goblin)-> bool: 
		return gobbo.stateMachine.CanTakeNewPosition() and gobbo.IsWaypointCloserThanCurrent(waypoint))
	
	var positionToFind := waypoint.global_position
	
	var sortFunc := func(gob1:Goblin, gob2: Goblin) -> bool:
		var gob1Distance = gob1.global_position.distance_squared_to(positionToFind)
		var gob2Distance = gob2.global_position.distance_squared_to(positionToFind)
		return gob1Distance < gob2Distance
	toFind.sort_custom(sortFunc)
		
	return toFind.front() if !toFind.is_empty() else null
		
