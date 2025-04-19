class_name WaypointMarker extends Area2D

@export var activeTimeout := 10.0
@export var inactiveTimeout := 5.0

@onready var activeSprite : Sprite2D = $ActiveSprite
@onready var inactiveSprite : Sprite2D = $InactiveSprite

var findGoblinTimer := 0.1

@onready var active = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		activeTimeout -= delta
		if activeTimeout < 0:
			set_inactive()
		
			findGoblinTimer -= delta
	if findGoblinTimer < 0:
		findGoblinTimer = 0.1
		var closetGobbo = GameManager.goblins.findGoblinCanMoveClosestToPosition(global_position)
		closetGobbo.setWaypoint(self)

	else:
		inactiveTimeout -= delta
		if inactiveTimeout < 0:
			queue_free()


func set_inactive() -> void:
	activeSprite.visible = false
	inactiveSprite.visible = true
	active = false
