extends Node2D

func _on_yes_pressed() -> void:
	Game.start(get_tree())

func _on_no_pressed() -> void:
	Game.quit(get_tree())
