extends Area2D

@onready var respawn_point: Marker2D = $respawn_point


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.set_checkpoint_position(respawn_point.global_position)
