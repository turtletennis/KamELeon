extends TileMapLayer


func _physics_process(delta: float) -> void:
	if GameManager.player.current_color == 2:
		collision_enabled = false
	else:
		collision_enabled = true
