extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var current_speed : float = 0
var max_speed : float = 400
var eccel_speed : float = 600
var deccel_speed : float = 900
var direction : int 

func _ready() -> void:
	GameManager.set_player(self)

func _process(delta: float) -> void: 
	animation_control()
	movement_management(delta)
	move_and_slide()



func animation_control():
	if abs(velocity.x) > abs(velocity.y):
		if velocity.x < 0:
			animated_sprite_2d.play("walk_left")
			direction = 1
		elif velocity.x > 0:
			animated_sprite_2d.play("walk_right")
			direction = 2
	elif abs(velocity.y) > 0:
		if velocity.y < 0:
			animated_sprite_2d.play("walk_up")
			direction = 3
		elif velocity.y > 0:
			animated_sprite_2d.play("walk_down")
			direction = 4
	
	else:
		if direction == 1:
			animated_sprite_2d.play("idle_left")
		if direction == 2:
			animated_sprite_2d.play("idle_right")
		if direction == 3:
			animated_sprite_2d.play("idle_up")
		if direction == 4:
			animated_sprite_2d.play("idle_down")
func movement_management(delta):
	var direction := Vector2.ZERO
	direction = direction.normalized() 
	
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * max_speed, eccel_speed * delta)
	elif direction == Vector2(0,0):
		velocity = velocity.move_toward(Vector2(0,0), deccel_speed * delta)
