class_name GoblinIdleState extends GoblinBaseState

func EnterState():
	ourBody.navigation_agent_2d.avoidance_priority = randf_range(0.1, 0.3)
	ourBody.navigation_agent_2d.avoidance_enabled = true
	#ourBody.velocity = Vector2.ZERO

func Update(delta: float):
	ourBody.moveOnPath()
	
func CanTakeNewPosition() -> bool:
	return true

func DoAnimationControl() -> void:
	if ourBody.velocity.length() < 0.1:
		if ourBody.heldItem:
			ourBody.animated_sprite_2d.play("idle_with_book")
		else: 
			ourBody.animated_sprite_2d.play("idle")
