class_name GoblinAsleepState extends GoblinBaseState

func EnterState():
	ourBody.animated_sprite_2d.self_modulate = Color.DARK_GRAY
	ourBody.navigation_agent_2d.avoidance_enabled = false



func Update(delta: float):
	pass

func OnDetection(body: Node2D) -> Constants.GoblinState:
	if body is Player:
		return Constants.GoblinState.Idle
	var other = body as Goblin
	if other != null and other.CanAwaken():
		return Constants.GoblinState.Idle

	return state

func CanAwaken() -> bool:
	return false
