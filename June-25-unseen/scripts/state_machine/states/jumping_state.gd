extends PlayerState



func enter():
	player.animation.play("jump")
	player.velocity.y = 0
	player.velocity.y -= player.jump_power



func physics_process_state(delta: float) -> void:
	#check for double jump
	if Input.is_action_just_pressed("jump"):
		if player.double_jump_available:
			transitioned.emit.call_deferred(self, "jumping")
			player.double_jump_available = false
	# applying gravity
	player.velocity.y += player.jump_gravity * delta
	
	# horizontal movement 
	if direction != 0:
		player.velocity.x = move_toward(player.velocity.x, player.air_movement_speed * direction, player.acceleration * delta)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.decceleration * delta)

	# checking for fall
	if player.velocity.y >= 0:
		transitioned.emit.call_deferred(self, "falling")

func exit():
	pass
