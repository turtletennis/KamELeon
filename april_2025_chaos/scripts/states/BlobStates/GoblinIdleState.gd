class_name GoblinIdleState extends GoblinBaseState

func EnterState():
	ourBody.animated_sprite_2d.self_modulate = Color.BLUE
	ourBody.navigation_agent_2d.avoidance_priority = randf_range(0.1, 0.3)


func Update(delta: float):
	pass
	
func CanTakeNewPosition() -> bool:
	return true

func DoAnimationControl() -> void:
	match ourBody.direction:
		1: ourBody.animated_sprite_2d.play("left_idle")
		2: ourBody.animated_sprite_2d.play("right_idle")
		3: ourBody.animated_sprite_2d.play("up_idle")
		4: ourBody.animated_sprite_2d.play("down_idle")
