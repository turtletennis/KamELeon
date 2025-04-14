extends Control

@onready var settings: Node2D = $settings
@onready var credits: Node2D = $credits
@onready var level_select: Node2D = $level_select



func _on_start_button_pressed() -> void:
	pass # lucy decide how oyu want to proceed lol


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

	
