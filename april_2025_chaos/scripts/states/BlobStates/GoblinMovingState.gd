class_name GoblinMovingState extends GoblinBaseState

var lastPosition:=Vector2.ZERO

func EnterState():
	ourBody.animated_sprite_2d.self_modulate = Color.RED
	ourBody.navigation_agent_2d.avoidance_priority = randf_range(0.7, 1.0)


func Update(delta: float):
	ourBody.moveOnPath()

func CanTakeNewPosition() -> bool:
	return true

func DoAnimationControl() -> void:
	var movement = ourBody.global_position - lastPosition
	if abs(movement.x) > abs(movement.y):
		if movement.x < 0:
			ourBody.animated_sprite_2d.play("left")
			ourBody.direction = 1
		else:
			ourBody.animated_sprite_2d.play("right")
			ourBody.direction = 2
	else:
		if movement.y < 0:
			ourBody.animated_sprite_2d.play("up")
			ourBody.direction = 3
		else:
			ourBody.animated_sprite_2d.play("down")
			ourBody.direction = 4
	
	lastPosition = ourBody.global_position
