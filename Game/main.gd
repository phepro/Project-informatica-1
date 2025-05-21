extends Node

@onready var asp = $AudioStreamPlayer
@onready var pause_menu = $pause_menu
var paused  = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	asp.play()
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pausemenu()

func pausemenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused


func _on_start_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")


func _on_fullscreen_button_button_down() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_windowed_button_button_down() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
