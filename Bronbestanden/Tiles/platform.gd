extends StaticBody2D
var Player_above := false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("move_down"):
		$CollisionShape2D.set_deferred("disabled", true)
		await get_tree().create_timer(0.1).timeout
		$CollisionShape2D.set_deferred("disabled", false)
