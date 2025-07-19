extends PlayerState


func enter():
	player.animation.play("wall_slide")
	


func physics_process_state(delta: float) -> void:
	# Check for valid wall slide based on wall direction and input
	var pushing_against_wall = (
		(wall_direction and direction > 0) or
		(!wall_direction and direction < 0)
	)

	if pushing_against_wall and player.on_any_wall:
		player.velocity.y = move_toward(player.velocity.y, player.wall_slide_speed, player.wall_friction * delta)

		if Input.is_action_just_pressed("jump"):
			transitioned.emit.call_deferred(self, "wall_jump")
	else:
		transitioned.emit.call_deferred(self, "falling")

	# Check if grounded
	if player.is_on_floor():
		transitioned.emit.call_deferred(self, "idle")

func exit():
	pass
