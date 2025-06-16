extends PlayerState



func enter():
	player.velocity.x = 0
	player.animation.play("death")
	
	


func physics_process_state(delta: float) -> void:
	pass



func exit():
	pass
