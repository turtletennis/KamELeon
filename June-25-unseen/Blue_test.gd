extends TileMapLayer

func _physics_process(delta: float) -> void:
	if GameManager.player.current_color == 1:
		collision_enabled = false
	else:
		collision_enabled = true
