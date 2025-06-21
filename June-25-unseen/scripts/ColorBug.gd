extends Area2D

@export var bug_resource : Resource
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var color_index:ChameleonColour.Colour = bug_resource.color_index
@onready var eat_sfxPlayer:AudioStreamPlayer2D = $AudioStreamPlayer2D_sfx

func _ready() -> void:
	sprite_2d.texture = bug_resource.texture



func _on_body_entered(body: Node2D) -> void:
	if visible && body.is_in_group("player"):
		GameManager.change_color(color_index)
		eat_sfxPlayer.play()
		visible = false
		var timer = get_tree().create_timer(1)
		timer.timeout.connect(_make_visible)

func _make_visible():
	visible = true
