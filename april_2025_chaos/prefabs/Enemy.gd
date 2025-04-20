extends PathFollow2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var speed: float = 100.0
var last_position: Vector2

func _ready():
	last_position = global_position

func _process(delta):
	progress += speed * delta

	var current_position = global_position
	var direction = current_position.x - last_position.x

	if direction != 0:
		if direction > 0:
			animated_sprite_2d.flip_h = true
		else: 
			animated_sprite_2d.flip_h = false

	last_position = current_position
