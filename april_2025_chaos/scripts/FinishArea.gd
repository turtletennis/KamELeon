extends Node2D

@onready var sheep_collected_label: Label = $sheep_collected_label
var sheep_collected : int = 0

func _ready() -> void:
	sheep_collected_label.text = str(sheep_collected)

func _on_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("goblin"):
		body.reached_goal()
		sheep_collected += 1
		sheep_collected_label.text = str(sheep_collected)
