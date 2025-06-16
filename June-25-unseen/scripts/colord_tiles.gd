extends TileMapLayer

@export var color_index : int

func _process(delta: float) -> void:
	if GameManager.player.current_color == color_index:
		collision_enabled = false
	else: 
		collision_enabled = true
