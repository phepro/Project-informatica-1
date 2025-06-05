extends Area2D


func _on_body_entered(body: Node2D) -> void:
	body.velocity.y = -800
	$CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(0.1).timeout
	$CollisionShape2D.set_deferred("disabled", false)
