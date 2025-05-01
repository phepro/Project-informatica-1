extends RigidBody2D
var player_position = Vector2(0, 0)
var speed = 10


func _physics_process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	queue_free()
