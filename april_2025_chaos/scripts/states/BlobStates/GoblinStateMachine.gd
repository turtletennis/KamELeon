class_name GoblinStateMachine extends StateMachine

func _init(gob:Goblin) -> void:
	stateList[Constants.GoblinState.Asleep] = GoblinAsleepState.new(gob, Constants.GoblinState.Asleep)
	stateList[Constants.GoblinState.Idle] = GoblinIdleState.new(gob, Constants.GoblinState.Idle)
	stateList[Constants.GoblinState.Moving] = GoblinMovingState.new(gob, Constants.GoblinState.Moving)
	stateList[Constants.GoblinState.Working] = GoblinWorkingState.new(gob, Constants.GoblinState.Working)
	stateList[Constants.GoblinState.Dead] = GoblinDeadState.new(gob, Constants.GoblinState.Dead)

func CanBePickedUp() -> bool:
	return currentState != null and currentState.CanBePickedUp()
