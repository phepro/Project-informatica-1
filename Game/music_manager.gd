extends AudioStreamPlayer
# alle code rond de music manager is geschreven door chatgpt
@onready var player = $AudioStreamPlayer
var playlists = {
	"level1": [
		preload("res://Project_139.wav") as AudioStream,
		preload("res://Project_142.wav") as AudioStream
	],
	"level2": [
		preload("res://Project_139.wav") as AudioStream,
		preload("res://Project_142.wav") as AudioStream
	],
}
var current_playlist: Array[AudioStream] = []
var current_index := 0

func play_playlist(level_name: String):
	var raw_playlist = playlists.get(level_name, [])
	
	# Rebuild as a strictly typed Array[AudioStream]
	current_playlist.clear()
	for item in raw_playlist:
		if item is AudioStream:
			current_playlist.append(item)
	current_index = 0
	play_next()

func _ready():
	player.finished.connect(_on_AudioStreamPlayer_finished)

func play_next():
	if current_playlist.is_empty():
		return

	var stream = current_playlist[current_index]

	# Disable loop safely depending on type
	if stream is AudioStreamWAV:
		(stream as AudioStreamWAV).loop_mode = AudioStreamWAV.LOOP_DISABLED

	player.stream = stream
	player.play()


func _on_AudioStreamPlayer_finished():
	current_index = (current_index + 1) % current_playlist.size()
	play_next()
