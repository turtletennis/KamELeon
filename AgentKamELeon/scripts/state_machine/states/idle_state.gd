extends PlayerState



func enter():
	player.animation.play("idle")
	player.velocity.x = 0


func physics_process_state(delta: float) -> void:
	#check for jump
	if Input.is_action_just_pressed("jump"):
		transitioned.emit.call_deferred(self, "jumping")
	# check for running
	if direction != 0:
		transitioned.emit.call_deferred(self, "running")



func exit():
	pass
