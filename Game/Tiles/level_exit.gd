extends Area2D
signal LEpos(Position, size)

func _ready() -> void:
	var size = $CollisionShape2D.shape.size.x / 2
	var LEposition = position
	LEposition.x += size * scale.x
	emit_signal("LEpos", LEposition)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int() + 1
		
		var next_level_path = "res://Levels/level_" + str(next_level_number) + ".tscn"
		if get_tree():
			get_tree().change_scene_to_file(next_level_path)
		if get_tree():
			get_tree().reload_current_scene()
