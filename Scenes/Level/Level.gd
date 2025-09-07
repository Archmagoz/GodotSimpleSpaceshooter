extends Node2D

var ufo_scene: PackedScene = preload("res://Entities/Enemy/Ufo/Ufo.tscn")

func _ready() -> void:
	pass

func _on_ufo_spawnner_timeout() -> void:
	var ufo: Object = ufo_scene.instantiate()
	add_child(ufo)
