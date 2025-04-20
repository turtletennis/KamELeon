class_name GoblinDeadState extends GoblinBaseState

func EnterState():
	ourBody.queue_free()
	ourBody.navigation_agent_2d.avoidance_enabled = false

func CanAwaken() -> bool:
	return false
