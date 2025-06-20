extends CanvasLayer

class_name Fade
@onready var animationPlayer:AnimationPlayer = $AnimationPlayer
func _ready() -> void:
    if(!animationPlayer.is_playing()):
        fadeFromBlack()
    GameManager.fade = self
    GameManager.level_complete.connect(fadeToBlack)
    
func fadeToBlack():
    animationPlayer.play("fade_to_black")

    
func fadeFromBlack():
    animationPlayer.play("fade_from_black")