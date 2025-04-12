extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var screen_fade_in_progress : bool

func play():
	animation_player.play("screen_fade")
	screen_fade_in_progress = true 


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	screen_fade_in_progress = false
