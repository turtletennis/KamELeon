extends Control

@export var firstScene:PackedScene

func StartGame():
    get_tree().change_scene_to_packed(firstScene)