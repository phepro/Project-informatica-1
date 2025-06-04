extends Control

@onready var menu_click = $menu_click
@onready var menu_hover = $menu_hover

#var _is_paused:bool = false:
	#set = set_paused 
	

var _is_paused:bool = false:
	set(value):
		_is_paused = value
		get_tree().paused = _is_paused
		visible = _is_paused
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_is_paused = !_is_paused
		
	
#func set_paused(value:bool) ->void:
	#_is_paused = value
	#get_tree().paused = _is_paused
	#visible = _is_paused


func _on_resume_pressed() -> void:
	_is_paused = false
	menu_click.play()


func _on_settings_pressed() -> void:
	menu_click.play()
	_is_paused = false
	get_tree().change_scene_to_file("res://main.tscn")


func _on_quit_pressed() -> void:
	menu_click.play()
	get_tree().quit()
