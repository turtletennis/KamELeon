extends PathFollow2D

@export var speed : float = 100
var direction : bool = true 

func _physics_process(delta: float) -> void:
	if direction:
		progress += speed * delta
	else:
		progress -= speed * delta 
	
	if progress_ratio == 1:
		direction = false
	elif progress_ratio == 0:
		direction = true 
		
