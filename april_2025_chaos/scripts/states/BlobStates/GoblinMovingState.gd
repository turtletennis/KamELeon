class_name GoblinMovingState extends GoblinBaseState

var lastPosition:=Vector2.ZERO

func EnterState():
	#ourBody.animated_sprite_2d.self_modulate = Color.RED
	ourBody.navigation_agent_2d.avoidance_priority = randf_range(0.5, 0.7)
	ourBody.navigation_agent_2d.avoidance_enabled = false
	ourBody.navigation_agent_2d.target_desired_distance = randf_range(10.0, 70.0)


func Update(delta: float):
	ourBody.moveOnPath()

func CanTakeNewPosition() -> bool:
	return true

func DoAnimationControl() -> void:
	var bookOnHead = ourBody.heldItem

	var movement = ourBody.global_position - lastPosition
	
	if movement.x < 0:
		ourBody.animated_sprite_2d.flip_h = true
		ourBody.direction = 1
		if bookOnHead:
			ourBody.animated_sprite_2d.play("run_with_book")
		else:
			ourBody.animated_sprite_2d.play("run_no_book")
		
	else:
		ourBody.animated_sprite_2d.flip_h = false
		ourBody.direction = 2
		if bookOnHead:
			ourBody.animated_sprite_2d.play("run_with_book")
		else:
			ourBody.animated_sprite_2d.play("run_no_book")
		

	if movement.y < 0:
		if bookOnHead:
			ourBody.animated_sprite_2d.play("run_with_book")
		else:
			ourBody.animated_sprite_2d.play("run_no_book")
		ourBody.direction = 3
	else:
		if bookOnHead:
			ourBody.animated_sprite_2d.play("run_with_book")
		else:
			ourBody.animated_sprite_2d.play("run_no_book")
		ourBody.direction = 4
	
	
	lastPosition = ourBody.global_position

func OnDetection(body: Node2D) -> Constants.GoblinState:
	var book := body as CollectItem
	if book != null and book.worker == null:
		ourBody.setWorkTarget(book)
		return Constants.GoblinState.MovingToTask
	
	return state
