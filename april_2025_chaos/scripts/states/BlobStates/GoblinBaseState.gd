class_name GoblinBaseState extends BaseState

var ourBody : Goblin
var state : int

func _init(gob: Goblin, stateNum:Constants.GoblinState) -> void:
	ourBody = gob
	state = stateNum
