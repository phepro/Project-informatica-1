extends RigidBody2D
var player_position = Vector2(0, 0)
var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	queue_free()
