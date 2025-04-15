extends CanvasLayer

@onready var audio_settings: Node2D = $Control/Audio_settings

var paused : bool 

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if !paused:
			pause()
		else:
			unpause()

func _on_resume_button_pressed() -> void:
	unpause()


func _on_settings_button_pressed() -> void:
	audio_settings.visible = !audio_settings.visible


func _on_menu_button_pressed() -> void:
	unpause()
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


func pause():
	paused = true
	self.visible = true
	get_tree().paused= true

func unpause():
	paused = false
	self.visible = false
	get_tree().paused = false


func _on_save_button_pressed() -> void:
	Save_Load.save()
