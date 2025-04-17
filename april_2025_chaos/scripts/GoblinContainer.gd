extends Node

@onready var goblins : Array = self.get_children()

func _ready() -> void:
	GameManager.set_goblins(goblins)
