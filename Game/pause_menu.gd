extends Control

@onready var main = $"../../"
@onready var menu_click = $menu_click
@onready var menu_hover = $menu_hover

func _on_resume_pressed() -> void:
	menu_click.play()
	main.pausemenu()


func _on_resume_mouse_entered() -> void:
	menu_hover.play()


func _on_quit_pressed() -> void:
	menu_click.play()
	get_tree().quit()


func _on_quit_mouse_entered() -> void:
	menu_hover.play()
