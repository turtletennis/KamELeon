class_name CollectionPoint extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var total_level_books : int
var books_recieved : int

func _process(delta: float) -> void:
	animation_control()
	
func book_revieved():
	books_recieved += 1
	if books_recieved == total_level_books:
		level_complete()



func book_destroyed():

	total_level_books -= 1
	print(total_level_books)
	if total_level_books == 0:
		get_parent().get_parent().failed_level()

func level_complete():
	get_parent().get_parent().finished_level()

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


func _on_body_entered(body: Node2D) -> void:
	var gobbo = body as Goblin
	if gobbo != null and gobbo.heldItem:
		book_revieved()
		gobbo.dropBook()
