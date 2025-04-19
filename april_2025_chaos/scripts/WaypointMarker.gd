class_name WaypointMarker extends Area2D

@export var activeTimeout := 10.0
@export var inactiveTimeout := 5.0

@onready var activeSprite : Sprite2D = $ActiveSprite
@onready var inactiveSprite : Sprite2D = $InactiveSprite


@onready var active = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		activeTimeout -= delta
		if activeTimeout < 0:
			set_inactive()
	else:
		inactiveTimeout -= delta
		if inactiveTimeout < 0:
			queue_free()

func set_inactive() -> void:
	activeSprite.visible = false
	inactiveSprite.visible = true
	active = false
