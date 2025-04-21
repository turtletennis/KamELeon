extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var total_level_books : int
var books_recieved : int

func _process(delta: float) -> void:
	animation_control()
	
func add_book():
	books_recieved += 1
	if books_recieved == total_level_books:
		level_complete()

func level_complete():
	pass

func animation_control():
	if books_recieved == 0:
		animated_sprite_2d.play("mimic_closed_0")
	elif books_recieved == total_level_books/4:
		animated_sprite_2d.play("mimic_closed_1")
	elif books_recieved == total_level_books/2:
		animated_sprite_2d.play("mimic_closed_2")
	elif books_recieved == (total_level_books/4) * 3:
		animated_sprite_2d.play("mimic_closed_3")
	elif books_recieved == total_level_books:
		animated_sprite_2d.play("mimic_open")
