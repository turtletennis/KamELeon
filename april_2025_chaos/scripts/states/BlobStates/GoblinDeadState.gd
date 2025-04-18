class_name GoblinDeadState extends GoblinBaseState

func EnterState():
	ourBody.queue_free()
