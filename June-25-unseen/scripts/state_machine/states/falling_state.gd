extends PlayerState

@onready var jump_buffer_timer: Timer = $jump_buffer_timer
var jump_queued : bool = false

func enter():
	player.animation.play("fall")
	


func physics_process_state(delta: float) -> void:
	
	if Input.is_action_just_pressed("jump"):
		#checking for coyotee time
		if player.coyotee_time_active:
			player.velocity.y = 0
			transitioned.emit.call_deferred(self, "jumping")
		# check for double jump 
		elif player.double_jump_available:
			transitioned.emit.call_deferred(self, "jumping")
			player.double_jump_available = false

		
		# creating jump buffer (so player cna press jump just before landing on the ground)
		jump_queued = true
		jump_buffer_timer.start()
	
	# apply gravity 
	player.velocity.y += player.fall_gravity * delta
	player.velocity.y = clamp(player.velocity.y, -INF, player.max_fall_speed)
	
	# horizontal movement 
	if direction != 0:
		player.velocity.x = move_toward(player.velocity.x, player.air_movement_speed * direction, player.acceleration * delta)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.decceleration * delta)
	
	# check if jump_queued otherwise send to landing
	if player.is_on_floor():
		if jump_queued:
			transitioned.emit.call_deferred(self, "jumping")
		else:
			transitioned.emit.call_deferred(self, "landing")
	
	# check for wall slide
	if player.is_on_wall() and direction !=0:
		if player.on_any_wall:
			transitioned.emit.call_deferred(self, "wall_slide")
	
	# check for running
	if player.is_on_floor() and direction != 0:
		transitioned.emit.call_deferred(self, "running")


	

func exit():
	jump_buffer_timer.stop()
	jump_queued = false


func _on_jump_buffer_timer_timeout() -> void:
	jump_queued = false
