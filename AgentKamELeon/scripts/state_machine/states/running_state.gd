extends PlayerState

func enter():
	player.animation.play("run")



func physics_process_state(delta: float) -> void:
	#check for jumping 
	if Input.is_action_just_pressed("jump"):
		transitioned.emit.call_deferred(self, "jumping")
	# horizontal movement 
	if direction != 0:
		player.velocity.x = move_toward(player.velocity.x, player.movement_speed * direction, player.acceleration * delta)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.decceleration * delta)

	# check for idle
	if player.velocity.x == 0 and direction == 0:
		transitioned.emit.call_deferred(self, "idle")
	
	# check for falling 
	if !player.is_on_floor():
		player.coyotee_time()
		transitioned.emit.call_deferred(self, "falling")

func exit():
	pass
