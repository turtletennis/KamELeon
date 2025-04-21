extends Node2D

@export var level_number : int
@export var next_level : PackedScene



func _ready() -> void:
	GameManager.set_highest_level(level_number)

func finished_level():
	if !next_level == null:
		SceneLoader.change_to_scene(next_level)
	else:
		print("no next level assigned")
	
func failed_level():
	await get_tree().physics_frame
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
