class_name GoblinWorkingState extends GoblinBaseState

func EnterState():
	#ourBody.animated_sprite_2d.self_modulate = Color.GREEN
	ourBody.navigation_agent_2d.avoidance_priority = randf_range(0.9, 1.0)
	ourBody.navigation_agent_2d.avoidance_enabled = false
	waitPickupComplete.call_deferred()

func Update(delta: float) -> int:
	ourBody.moveOnPath()
	if ourBody.heldItem:
		return Constants.GoblinState.Idle
	
	return state

func CanTakeNewPosition() -> bool:
	return false

func DoAnimationControl() -> void:
	if !ourBody.heldItem:
		ourBody.animated_sprite_2d.play("pick_up_book")

func waitPickupComplete() -> void:
	await ourBody.animated_sprite_2d.animation_finished
	ourBody.workCompleted()
	
