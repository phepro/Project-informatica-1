extends Area2D
signal hit
@export var speed = 400
var x_velocity = 0
var y_velocity = 0
var collision_height
var collision_width
var raycast_collision
var screen_size
var touching_ground = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	collision_height = $CollisionShape2D.shape.size.y / 2
	collision_width = $CollisionShape2D.shape.size.x / 2


#returns the maximum/minimum value that isn't zero
func compare_non_zero(a, b, mode):
	if a == 0:
		return b
	if b == 0:
		return a
	if mode == "min":
		return min(a, b)
	if mode == "max":
		return max(a, b)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	x_velocity = 0
	if Input.is_action_pressed("move_right"):
		x_velocity += 1
	if Input.is_action_pressed("move_left"):
		x_velocity -= 1
	if Input.is_action_pressed("move_up"):
		if touching_ground:
			y_velocity = -640
	if Input.is_action_pressed("move_down"):
		y_velocity += 1


func _physics_process(delta) -> void:
	#gravity
	if !touching_ground:
		y_velocity += 1280 * delta
	
	#moves the player
	position.x += x_velocity * delta * speed
	position.y += y_velocity * delta
	
	#Checks for raycast hit
	if $RayCast2D_Left1.is_colliding() or $RayCast2D_Left2.is_colliding():
		raycast_collision = compare_non_zero($RayCast2D_Left1.get_collision_point().x, $RayCast2D_Left2.get_collision_point().x, "max")
		position.x = max(position.x, raycast_collision + collision_width)
	if $RayCast2D_Right1.is_colliding() or $RayCast2D_Right2.is_colliding():
		raycast_collision = compare_non_zero($RayCast2D_Right1.get_collision_point().x, $RayCast2D_Right2.get_collision_point().x, "min")
		position.x = min(position.x, raycast_collision - collision_width)
	if $RayCast2D_Up1.is_colliding() or $RayCast2D_Up2.is_colliding():
		raycast_collision = compare_non_zero($RayCast2D_Up1.get_collision_point().y, $RayCast2D_Up2.get_collision_point().y, "max")
		position.y = max(position.y, raycast_collision + collision_height)
	
	if $RayCast2D_Down1.is_colliding() or $RayCast2D_Down2.is_colliding():
		raycast_collision = compare_non_zero($RayCast2D_Down1.get_collision_point().y, $RayCast2D_Down2.get_collision_point().y, "min")
		#Pushes players out of collision boxes
		if position.y + collision_height >= raycast_collision:
			position.y = raycast_collision - collision_height
			touching_ground = true
			y_velocity = 0
		else:
			touching_ground = false
	else:
		touching_ground = false
	
	#checks if player goes below screen
	if position.y + collision_height >= screen_size.y:
		pass
		print("dead")


func _on_body_entered(body: Node2D) -> void:
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(3).timeout
	$CollisionShape2D.disabled = false

func start(pos):
	position = pos
	show()
