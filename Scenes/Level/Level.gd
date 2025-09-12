extends Node2D

const UFO_SCENE: PackedScene = preload("res://Entities/Enemy/Ufo/Ufo.tscn")

func _on_ufo_spawnner_timeout() -> void:
	var ufo: Object = UFO_SCENE.instantiate()
	add_child(ufo)
