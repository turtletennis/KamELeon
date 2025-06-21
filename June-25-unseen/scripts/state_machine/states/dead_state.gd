extends PlayerState



func enter():
	player.velocity.x = 0
	player.animation.play("death")
	GameManager.fade.fadeToBlack()
	player.death_particles.emitting = true
	player.death_sfx_player.play()
	var timer = get_tree().create_timer(player.time_to_respawn)
	timer.timeout.connect(_respawn) 
	
	
	
func _respawn():
	transitioned.emit.call_deferred(self, "falling")
	player.respawn()

func physics_process_state(delta: float) -> void:
	pass



func exit():
	pass
