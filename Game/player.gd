extends Area2D
signal hit
@export var speed = 600
var x_velocity = 0
var y_velocity = 0
var x_acceleration = 0
var y_acceleration = 0
var screen_size
var collision_radius
var touching_ground

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	collision_radius = $CollisionShape2D.shape.size.y / 2
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	x_velocity = 0
	y_velocity = 0
	if Input.is_action_pressed("move_right"):
		x_velocity += 1
	if Input.is_action_pressed("move_left"):
		x_velocity -= 1
	if Input.is_action_pressed("move_up"):
		if touching_ground:
			y_acceleration = -40
	if Input.is_action_pressed("move_down"):
		y_velocity += 1
	
	#Creates the raycast and checks for collision
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(Vector2(position.x, position.y), Vector2(position.x, position.y + 400))
	var result = space_state.intersect_ray(query)
	
	#gravity
	if !touching_ground:
		y_acceleration += 1
	
	#calculates velocity
	x_velocity += x_acceleration * delta
	y_velocity += y_acceleration * delta
	
	
	#moves the player
	position.x += x_velocity * speed * delta
	position.y += y_velocity * speed * delta
	if result:
		position.y = min(position.y, result.position.y)
		if position.y == result.position.y:
			touching_ground = true
			y_acceleration = 0
		else:
			touching_ground = false
	else:
		touching_ground = false
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_body_entered(body: Node2D) -> void:
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(3).timeout
	$CollisionShape2D.disabled = false

func start(pos):
	position = pos
	show()
