class_name GoblinIdleState extends GoblinBaseState

func EnterState():
	ourBody.animated_sprite_2d.self_modulate = Color.BLUE
	ourBody.navigation_agent_2d.avoidance_priority = randf_range(0.1, 0.3)
	ourBody.navigation_agent_2d.avoidance_enabled = false



func Update(delta: float):
	pass
	
func CanTakeNewPosition() -> bool:
	return true

func DoAnimationControl() -> void:
	print(ourBody.velocity)
	if ourBody.velocity == Vector2.ZERO:
		if ourBody.heldItem:
			ourBody.animated_sprite_2d.play("idle_no_book")
		else: 
			ourBody.animated_sprite_2d.play("idle_no_book")
