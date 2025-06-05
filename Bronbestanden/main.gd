extends Node

@onready var menu_click = $menu_click
@onready var menu_hover = $menu_hover

var paused  = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicManager.play_playlist("main_menu")

func _on_start_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://settings.tscn")


func _on_quit_pressed() -> void:
	menu_click.play()
	get_tree().quit()
