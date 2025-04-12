extends Node2D



func _on_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("sheep"):
		body.die()
