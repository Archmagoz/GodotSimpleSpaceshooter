extends Node2D

const GAMEOVER_SCENE: PackedScene = preload("res://Scenes/Gameover/Gameover.tscn")
const LEVEL_SCENE: PackedScene = preload("res://Scenes/Level/Level.tscn")

var w_size: Vector2

func _ready() -> void:
	Engine.max_fps = -1
	w_size = get_viewport_rect().size

func gameover(tree: SceneTree) -> void:
	tree.change_scene_to_packed(GAMEOVER_SCENE)

func start(tree: SceneTree) -> void:
	tree.change_scene_to_packed(LEVEL_SCENE)

func quit(tree: SceneTree) -> void:
	tree.quit()
