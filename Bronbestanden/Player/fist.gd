extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	queue_free()


#Deletes both mob and projectile when they both collide
func body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
		await get_tree().create_timer(0.1).timeout
		queue_free()
