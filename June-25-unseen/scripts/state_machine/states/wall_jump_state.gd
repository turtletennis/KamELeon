extends PlayerState


func enter():
	player.animation.play("jump")
	
	# apply jump
	player.velocity.y -= player.wall_jump_power
	if wall_direction:
		player.velocity.x -= player.wall_jump_power * 0.6
	else:
		player.velocity.x += player.wall_jump_power * 0.6


func physics_process_state(delta: float) -> void:
	# counter jump physics
	player.velocity.y += player.fall_gravity * delta

	#player.velocity.x = move_toward(player.velocity.x, 0, player.fall_gravity * delta)

	# check for falling
	if player.velocity.y >= 0:
		transitioned.emit.call_deferred(self, "falling")


func exit():
	pass
