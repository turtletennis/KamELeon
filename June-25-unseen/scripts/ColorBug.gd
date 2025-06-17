extends Area2D

@export var bug_resource : Resource
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var color_index = bug_resource.color_index

func _ready() -> void:
	sprite_2d.texture = bug_resource.texture



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.change_color(color_index)
		visible = false
		await get_tree().create_timer(1).timeout
		visible = true
