extends TileMapLayer


@export_enum ("Normal", "Red", "Blue", "Green") var color_index : int

func _ready() -> void:
	GameManager.color_changed.connect(change_color)


func change_color(color):
	if color == color_index:
		collision_enabled = false
	else: 
		collision_enabled = true
