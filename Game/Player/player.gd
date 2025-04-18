extends CharacterBody2D

@export var fist : PackedScene
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var can_punch = true

func _ready() -> void:
	var screen_size = get_viewport_rect().size


#Summons a fist
func punch():
	var f = fist.instantiate()
	add_child(f)
	f.transform = $Punch_Spawn.transform
	f.scale = Vector2(1.2, 0.6)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#punch
	if Input.is_action_pressed("punch"):
		if can_punch:
			can_punch = false
			punch()
			await get_tree().create_timer(1).timeout
			can_punch = true
	
	# Handle jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		if direction > 0:
			scale = Vector2(1, 1)
		if direction < 0:
			scale = Vector2(1, 1)
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
