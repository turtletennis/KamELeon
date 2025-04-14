extends CanvasLayer


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
	pass # Replace with function body.


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
