class_name GoblinStateMachine extends StateMachine

func _init(gob:Goblin, initialState: Constants.GoblinState = Constants.GoblinState.Idle ) -> void:
	stateList[Constants.GoblinState.Asleep] = GoblinAsleepState.new(gob, Constants.GoblinState.Asleep)
	stateList[Constants.GoblinState.Idle] = GoblinIdleState.new(gob, Constants.GoblinState.Idle)
	stateList[Constants.GoblinState.Moving] = GoblinMovingState.new(gob, Constants.GoblinState.Moving)
	stateList[Constants.GoblinState.Working] = GoblinWorkingState.new(gob, Constants.GoblinState.Working)
	stateList[Constants.GoblinState.Dead] = GoblinDeadState.new(gob, Constants.GoblinState.Dead)
	
	QueueSwapState(initialState)

func CanTakeNewPosition() -> bool:
	return currentState != null and currentState.CanTakeNewPosition()
	
func DoAnimationControl() -> void:
	currentState != null and currentState.DoAnimationControl()
