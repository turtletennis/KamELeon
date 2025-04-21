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
			findAndSummonGobbo.call_deferred()
	else:
		inactiveTimeout -= delta
		if inactiveTimeout < 0:
			queue_free()


func set_inactive() -> void:
	activeSprite.visible = false
	inactiveSprite.visible = true
	active = false

func findAndSummonGobbo() -> void:
	var closetGobbo = GameManager.goblins.findGoblinCanMoveClosestToPosition(self)
	if closetGobbo != null:
		closetGobbo.setWaypoint(self)


func _on_cancel_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("Cancel"):
		queue_free()
