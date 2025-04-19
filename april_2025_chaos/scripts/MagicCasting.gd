extends Area2D

@onready var collisionShape : CollisionShape2D = $detection_area
@onready var player := get_parent()

@export var maxDistanceFromPlayer : float = 300

@export var waypointSpell : PackedScene

func _physics_process(delta: float) -> void:
	var aimPoint = player.get_local_mouse_position()
	position = aimPoint.limit_length(maxDistanceFromPlayer)
	queue_redraw()


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Action"):
		cast_summon()

func cast_summon():
	var newWaypoint := waypointSpell.instantiate() as Node2D
	newWaypoint.global_position = global_position
	player.get_parent().add_child(newWaypoint)

	var goblinsInArea := get_overlapping_bodies()
	for gobbo: Goblin in goblinsInArea:
		gobbo.setWaypoint(newWaypoint)

func _draw() -> void:
	draw_circle(Vector2.ZERO, collisionShape.shape.radius, Color.RED, false)
