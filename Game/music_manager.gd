extends AudioStreamPlayer

@onready var player = $AudioStreamPlayer
var playlists = {
	"level1": [
		preload("res://Project_139.wav"),
		preload("res://Project_140.wav")
	],
	"level2": [
		preload("res://Project_139.wav"),
		preload("res://Project_140.wav")
	],
}
var current_playlist = []
var current_index := 0

func play_playlist(level_name: String):
	current_playlist = playlists.get(level_name, [])
	current_index = 0
	play_next()

func play_next():
	if current_playlist.size() == 0:
		return
	player.stream = current_playlist[current_index]
	player.play()

func _on_AudioStreamPlayer_finished():
	current_index = (current_index + 1) % current_playlist.size()
	play_next()
