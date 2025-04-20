class_name CollectItem extends Area2D

enum CollectType
{
	Empty = 0,
	Book = 1,
}
@export var type : CollectType

var worker : Goblin = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	var goblin := body as Goblin
	if goblin != null and worker == null:
		goblin.startWork(self)

func GetMoveToTarget() -> Vector2:
	return global_position

func WorkCompleted() -> void:
	queue_free()
