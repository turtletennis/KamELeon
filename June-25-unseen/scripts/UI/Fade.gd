extends CanvasLayer

class_name Fade
@onready var animationPlayer:AnimationPlayer = $AnimationPlayer
func _ready() -> void:
    GameManager.fade = self
    
func fadeToBlack():
    animationPlayer.play("fade_to_black")

    
func fadeFromBlack():
    animationPlayer.play("fade_from_black")