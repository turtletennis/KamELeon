extends PhysicsBody2D

class_name ColouredBlocker

@export var objectColour : ChameleonColour.Colour
@export var debug : bool = false
@export var disabledModulateColour:Color = Color(1,1,1,0.5)
var collisionObjects : Array[CollisionShape2D]


func _ready() -> void:
	GameManager.color_changed.connect(change_color)

	var children = find_children("*")
	print_debug("Children found count",children.size())
	for child in children:
		print_debug(child.name," is CollisionShape2D?",child is CollisionShape2D)
		if(child is CollisionShape2D):
			collisionObjects.push_back(child as CollisionShape2D)

func change_color(playerColour:ChameleonColour.Colour):
	
	var collision_disabled = objectColour == playerColour
	print_debug("Processing colour change, ",name," disabled? ",objectColour," == ",playerColour,"?",collision_disabled)
	if(collision_disabled):
		set_deferred("modulate",disabledModulateColour)
	else:
		set_deferred("modulate",Color.WHITE)
	for object in collisionObjects:
		object.set_deferred("disabled",collision_disabled)
