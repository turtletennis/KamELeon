extends CharacterBody2D


func _ready() -> void:
	GameManager.set_player(self)

func _process(delta: float) -> void: 
	global_position = get_global_mouse_position()
