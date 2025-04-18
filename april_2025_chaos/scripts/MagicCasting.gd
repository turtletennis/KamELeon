extends Area2D

@onready var collisionShape : CollisionShape2D = $detection_area


func _physics_process(delta: float) -> void:
	global_position = get_global_mouse_position()
	queue_redraw()


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Action"):
		cast_summon()

func cast_summon():
	for goblin in GameManager.goblins:
		goblin.add_point(get_global_mouse_position())

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("goblin"):
		print("entered")
		


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("goblin"):
		pass

func _draw() -> void:
	draw_circle(Vector2.ZERO, collisionShape.shape.radius, Color.RED, false)
