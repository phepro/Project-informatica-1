extends Control

#var music_player = MusicManager

@onready var menu_click = $menu_click
@onready var menu_hover = $menu_hover

func _ready() -> void:
	MusicManager.play_playlist("settings")

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		# Turn music ON: set volume to 0 dB (normal)
		MusicManager.player.volume_db = -80
		
	else:
		# Turn music OFF: set volume to -80 dB (silence)
		MusicManager.player.volume_db = 0

func _on_windowed_pressed() -> void:
	menu_click.play()
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_fullscreen_pressed() -> void:
	menu_click.play()
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
