extends CharacterBody2D

@export var SPEED = 10
@onready var _animated_sprite = $AnimatedSprite2D
@export var bullet : PackedScene

func _ready() -> void:
	_animated_sprite.play("walk")


func shoot() -> void:
	var b = bullet.instantiate()
	add_child(b)
	b.direction = -scale.y


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = SPEED * -scale.y
	
	move_and_slide()
	
	#This is to 'fix' a bug
	var collision_names = []
	
	#Checks all collision made after movement
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		#Checks for collision with Environment and wall
		if collider.is_in_group("environment") and is_on_wall() and str(collider.name) not in collision_names:
			scale.x = -scale.x
			position.x -= 5 * scale.y
		
		collision_names.append(str(collider.name))


func _on_attack_cooldown_timeout() -> void:
	shoot()
