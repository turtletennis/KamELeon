extends PlayerState



func enter():
	player.velocity.x = 0
	player.animation.play("death")
	GameManager.fade.fadeToBlack()
	player.death_particles.emitting = true
	await get_tree().create_timer(player.time_to_respawn).timeout 
	transitioned.emit.call_deferred(self, "falling")
	player.respawn()
	
	


func physics_process_state(delta: float) -> void:
	pass



func exit():
	pass
