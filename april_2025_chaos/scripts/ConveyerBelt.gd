extends Node2D

@export_enum("up", "down", "left", "right") var direction : String
@export var conveyer_speed : int


func _on_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") or body.is_in_group("goblin"):
		body.entered_conveyer(direction, conveyer_speed)
		


func _on_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") or body.is_in_group("goblin"):
		body.exited_conveyer()
