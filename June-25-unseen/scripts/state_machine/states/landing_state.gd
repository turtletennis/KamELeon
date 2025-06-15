extends PlayerState



func enter():
	pass


func physics_process_state(delta: float) -> void:
	# check for idle
	if player.is_on_floor() and direction != 0:
		transitioned.emit.call_deferred(self, "running")
	else:
		transitioned.emit.call_deferred(self, "idle")



func exit():
	pass
