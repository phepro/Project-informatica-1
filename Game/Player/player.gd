extends CharacterBody2D

@export var fist : PackedScene
@export var SPEED = 200.0
@export var JUMP_VELOCITY = -300.0
@onready var _animated_sprite = $AnimatedSprite2D
@onready var punch_sfx = $AudioStreamPlayerPunch
@onready var ouch_sfx = $AudioStreamPlayer2D
var level = 0
var can_punch = true
var level_exit_pos = 1000000
var screen_size 

func _ready() -> void:
	screen_size = get_viewport_rect().size
	$Camera2D.limit_bottom = screen_size.y

#Summons a fist
func punch():
	var f = fist.instantiate()
	add_child(f)
	f.transform = $Punch_Spawn.transform
	f.scale = Vector2(1.2, 0.6)
	punch_sfx.play()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
	#punch
	if Input.is_action_pressed("punch"):
		if can_punch:
			_animated_sprite.play("punch")
			_animated_sprite.frame = 1
			can_punch = false
			punch()
			await get_tree().create_timer(1).timeout
			can_punch = true
			_animated_sprite.stop()
	
	# Handle jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		_animated_sprite.play("walk")
		if direction > 0:
			scale.x = scale.y * 1
		if direction < 0:
			scale.x = scale.y * -1
		velocity.x = direction * SPEED	
	else:
		_animated_sprite.stop()
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	position.x = clamp(position.x, 0, level_exit_pos)
	
	
	#checks all collision made after movement
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		#Checks for top collision with Enemies
		if collider.is_in_group("mobs") and is_on_floor_only():
			velocity.y = JUMP_VELOCITY
			collider.queue_free()
		#Checks for side collision with Enemies
		elif collider.is_in_group("mobs") and is_on_wall():
			if get_tree():
				ouch_sfx.play()
				get_tree().reload_current_scene()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if get_tree():
		ouch_sfx.play()
		get_tree().reload_current_scene()


func _on_level_enter(LEPosition: Variant) -> void:
	$Camera2D.limit_right = LEPosition.x
	level_exit_pos = LEPosition.x
