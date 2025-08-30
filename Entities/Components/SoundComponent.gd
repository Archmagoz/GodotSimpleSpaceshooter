extends Node2D

class_name SoundComponent

# Change in godot composition
@export var sound: AudioStream

# Set audio plauer
var audio_player: AudioStreamPlayer2D

# Play on load
func _ready() -> void:
	audio_player = AudioStreamPlayer2D.new()
	add_child(audio_player)
	audio_player.stream = sound
	if audio_player.stream:
		audio_player.play()
