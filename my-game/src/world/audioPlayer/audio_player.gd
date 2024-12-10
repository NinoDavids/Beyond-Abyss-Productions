extends Node

@onready var music_timer: Timer = %MusicTimer
@onready var music_player: AudioStreamPlayer = %MusicPlayer
@onready var ambience_player: AudioStreamPlayer = %AmbiencePlayer
@export var min_music_timer: float = 30.0
@export var max_music_timer: float = 60.0

func _ready() -> void:
	_on_music_player_finished()

func _on_music_timer_timeout() -> void:
	music_player.play()


func _on_music_player_finished() -> void:
	music_timer.wait_time = randf_range(min_music_timer, min_music_timer)
	music_timer.start()
