extends Node2D

@export var level_1 : PackedScene
@export var level_2 : PackedScene
@export var level_3 : PackedScene
@export var level_4 : PackedScene
@export var level_5 : PackedScene
@export var level_6 : PackedScene
@onready var level_1_button: Button = $NinePatchRect/GridContainer/level_1_button
@onready var level_2_button: Button = $NinePatchRect/GridContainer/level_2_button
@onready var level_3_button: Button = $NinePatchRect/GridContainer/level_3_button
@onready var level_4_button: Button = $NinePatchRect/GridContainer/level_4_button
@onready var level_5_button: Button = $NinePatchRect/GridContainer/level_5_button
@onready var level_6_button: Button = $NinePatchRect/GridContainer/level_6_button
@onready var levels : Array = [level_1, level_2, level_3, level_4, level_5, level_6]
@onready var buttons : Array = [level_1_button, level_2_button, level_3_button, level_4_button, level_5_button, level_6_button]

func _process(delta: float) -> void:
	check_if_level_available(GameManager.current_highest_level)

func _on_level_1_button_pressed() -> void:
	SceneLoader.change_to_scene(level_1)
	AudioManager.play_page_turn()


func _on_level_2_button_pressed() -> void:
	SceneLoader.change_to_scene(level_2)
	AudioManager.play_page_turn()


func _on_level_3_button_pressed() -> void:
	SceneLoader.change_to_scene(level_3)
	AudioManager.play_page_turn()


func _on_level_4_button_pressed() -> void:
	SceneLoader.change_to_scene(level_4)
	AudioManager.play_page_turn()


func _on_level_5_button_pressed() -> void:
	SceneLoader.change_to_scene(level_5)
	AudioManager.play_page_turn()


func _on_level_6_button_pressed() -> void:
	SceneLoader.change_to_scene(level_6)
	AudioManager.play_page_turn()

func check_if_level_available(current_highest_level : int):
	for i in buttons.size():
		var button = buttons[i]
		var level_number = i + 1
		if level_number > current_highest_level:
			button.disabled = true
		else: 
			button.disabled = false

func resume() -> void:
	var resume_level : int = GameManager.current_highest_level
	SceneLoader.change_to_scene(levels[resume_level - 1])
