extends RigidBody2D
var player_position = Vector2.ZERO
var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	player_position = get_node("../player").position
	if player_position.x > position.x:
		position.x += speed * delta
	if player_position.x < position.x:
		position.x -= speed * delta


func _on_body_entered(body: Node) -> void:
	queue_free()
