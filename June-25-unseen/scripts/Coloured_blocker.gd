extends PhysicsBody2D

class_name ColouredBlocker

@export var colour : ChameleonColour.Colour
var collisionObjects : Array[CollisionShape2D]


func _ready() -> void:
	var children = find_children("*")
	print_debug("Children found count",children.size())
	for child in children:
		print_debug(child.name," is CollisionShape2D?",child is CollisionShape2D)
		if(child is CollisionShape2D):
			collisionObjects.push_back(child as CollisionShape2D)

func _process(delta: float) -> void:
	if(GameManager.player):
		var collision_disabled = GameManager.player.current_color == colour
		#print_debug(GameManager.player.current_color,"==",colour," ? ",collision_disabled)
		for object in collisionObjects:
			object.set_deferred("disabled",collision_disabled)
	else:
		print_debug("Player not found")
