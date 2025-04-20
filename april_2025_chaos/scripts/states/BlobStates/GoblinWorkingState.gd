class_name GoblinWorkingState extends GoblinBaseState

func EnterState():
	ourBody.animated_sprite_2d.self_modulate = Color.GREEN
	ourBody.navigation_agent_2d.avoidance_priority = randf_range(0.9, 1.0)
	ourBody.navigation_agent_2d.avoidance_enabled = false

func Update(delta: float) -> int:
	ourBody.moveOnPath()
	if ourBody.heldItem != null:
		return Constants.GoblinState.Idle
	
	return state

func CanTakeNewPosition() -> bool:
	return false
