extends Node2D
class_name HealthComponent

signal died

@export var max_health: int

var health: int

func _ready() -> void:
	health = max_health

func set_health(new_health: int) -> void:
	health = clamp(new_health, 0, max_health)

	if health <= 0:
		emit_signal("died")

func get_health() -> int:
	return health

func damage(amount: int) -> void:
	set_health(health - amount)
