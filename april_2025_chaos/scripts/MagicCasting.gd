extends Area2D



func _physics_process(delta: float) -> void:
	global_position = get_global_mouse_position()


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Action"):
		cast_summon()

func cast_summon():
	for goblin in GameManager.goblins:
		if goblin.in_detection:
			goblin.add_point(get_global_mouse_position())

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("goblin"):
		print("entered")
		body.enter_detection()
		


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("goblin"):
		body.exit_detection()
