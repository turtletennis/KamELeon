extends Control

@onready var settings: Node2D = $settings
@onready var credits: Node2D = $credits
@onready var level_select: Node2D = $level_select
@onready var resume_button: Button = $"GridContainer/resume button"
@onready var how_to_play: Node2D = $how_to_play



func _on_start_button_pressed() -> void:
	level_select._on_level_1_button_pressed()
	AudioManager.play_page_turn()


func _on_level_select_button_pressed() -> void:
	show_hide_level_select()
	AudioManager.play_page_turn()


func _on_settings_button_pressed() -> void:
	show_hide_settings()
	AudioManager.play_page_turn()


func _on_credits_button_pressed() -> void:
	show_hide_credits()
	AudioManager.play_page_turn()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	AudioManager.play_page_turn()

func show_hide_settings():
	credits.visible = false
	level_select.visible = false
	how_to_play.visible = false
	settings.visible = !settings.visible

func show_hide_credits():
	level_select.visible = false
	settings.visible = false
	how_to_play.visible = false
	credits.visible = !credits.visible

func show_hide_level_select():
	credits.visible = false
	settings.visible = false
	how_to_play.visible = false
	level_select.visible = !level_select.visible

	

@onready var no_save_label: Label = $"GridContainer/resume button/no_save_label"

func _ready() -> void:
	resume_button.disabled = !Save_Load.file_saved
	
func _init() -> void:
	print('something')

func _on_resume_button_pressed() -> void:
	level_select.resume()


func _on_how_to_play_button_pressed() -> void:
	credits.visible = false
	settings.visible = false
	level_select.visible = false
	how_to_play.visible = !how_to_play.visible
