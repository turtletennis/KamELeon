extends Area2D
@export var next_scene:PackedScene
@export var next_scene_timeout:float = 1
@onready var sfx_player:AudioStreamPlayer = $LevelComplete_AudioStreamPlayer
func _on_body_entered(body:Node2D) -> void:
		if body.is_in_group("player"):
						GameManager.complete_level()
						sfx_player.play()
						await get_tree().create_timer(next_scene_timeout).timeout
						print_debug("load scene") 
						get_tree().change_scene_to_packed(next_scene)
