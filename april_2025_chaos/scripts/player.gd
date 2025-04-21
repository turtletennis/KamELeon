class_name Player extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var current_speed : float = 0
var max_speed : float = 400
var eccel_speed : float = 1500
var deccel_speed : float = 2000
var direction : int 
var conveyer_direction : String
var on_conveyer : bool 
var conveyer_speed : int

func _ready() -> void:
	GameManager.set_player(self)

func _process(delta: float) -> void: 
	animation_control()
	movement_management(delta)
	move_and_slide()
	conveyer_movement()


func animation_control():

	if velocity.x < 0:
		animated_sprite_2d.flip_h = true
	elif velocity.x > 0:
		animated_sprite_2d.flip_h = false
	if velocity.y < 0:
		animated_sprite_2d.play("back_idle")
	elif velocity.y > 0:
		animated_sprite_2d.play("front_idle")
	else:
		animated_sprite_2d.play("front_idle")

func movement_management(delta):
	var direction := Vector2.ZERO
	direction = direction.normalized() 
	
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	await get_tree().physics_frame
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * max_speed, eccel_speed * delta)
	elif direction == Vector2(0,0):
		velocity = velocity.move_toward(Vector2(0,0), deccel_speed * delta)

func entered_conveyer(direction, speed):
	on_conveyer = true
	conveyer_speed = speed
	conveyer_direction = direction
func exited_conveyer():
	on_conveyer = false
func conveyer_movement():
	if on_conveyer:
		if conveyer_direction == "up":
			velocity.y = -conveyer_speed
		if conveyer_direction == "down":
			velocity.y = conveyer_speed
		if conveyer_direction == "left":
			velocity.x = -conveyer_speed
		if conveyer_direction == "right":
			velocity.x = conveyer_speed
