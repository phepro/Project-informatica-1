extends CharacterBody2D

const SPEED = 150.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = SPEED * scale.y
	

	move_and_slide()
	
	#checks all collision made after movement
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		#Checks for collision with Environment and wall
		if collider.collision_layer == 2 and is_on_wall():
			scale.x = -scale.x
			position.x -= 5 * scale.y
