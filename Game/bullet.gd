extends Area2D
@onready var _animated_sprite = $AnimatedSprite2D
var speed = 1
var direction = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_animated_sprite.play("default")


func _physics_process(delta: float) -> void:
	position.x += speed * direction


#Deletes both mob and projectile when they both collide
func body_entered(body):
	if body.is_in_group("player"):
		body._on_visible_on_screen_notifier_2d_screen_exited()
	if body.is_in_group("mobs"):
		pass
	else:
		queue_free()
