extends Control

@onready var settings: Node2D = $settings
@onready var credits: Node2D = $credits
@onready var level_select: Node2D = $level_select
@onready var level_1 : PackedScene = preload("res://scenes/levels/level_1.tscn")
@onready var level_2 : PackedScene = preload("res://scenes/levels/level_2.tscn")
@onready var level_3 : PackedScene = preload("res://scenes/levels/level_3.tscn")
@onready var level_4 : PackedScene = preload("res://scenes/levels/level_4.tscn")
@onready var level_5 : PackedScene = preload("res://scenes/levels/level_5.tscn")
@onready var level_6 : PackedScene = preload("res://scenes/levels/level_6.tscn")
@onready var levels : Array = [level_1, level_2, level_3, level_4, level_5, level_6]

func _on_start_button_pressed() -> void:
	SceneLoader.change_to_scene(level_1)


func _on_level_select_button_pressed() -> void:
	show_hide_level_select()


func _on_settings_button_pressed() -> void:
	show_hide_settings()


func _on_credits_button_pressed() -> void:
	show_hide_credits()


func _on_quit_button_pressed() -> void:
	get_tree().quit()

func show_hide_settings():
	if credits.visible:
		credits.visible = false
	if level_select.visible:
		level_select.visible = false
	settings.visible = !settings.visible

func show_hide_credits():
	if level_select.visible:
		level_select.visible = false
	if settings.visible:
		settings.visible = false
	credits.visible = !credits.visible

func show_hide_level_select():
	if credits.visible:
		credits.visible = false
	if settings.visible:
		settings.visible = false
	level_select.visible = !level_select.visible

	

@onready var no_save_label: Label = $"resume button/no_save_label"

func _on_resume_button_pressed() -> void:
	if Save_Load.file_saved == false:
		no_save_label.visible = true
		await get_tree().create_timer(1).timeout
		no_save_label.visible = false
	else:
		var resume_level : int = GameManager.current_highest_level
		SceneLoader.change_to_scene(levels[resume_level - 1])
