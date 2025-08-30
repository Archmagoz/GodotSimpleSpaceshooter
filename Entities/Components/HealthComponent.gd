extends Node2D

class_name HealthComponent

signal died

# Change on godot composition
@export var max_health: int

# logic variables
var health: int

#simple HealthComponent with died signal
func _ready() -> void:
	self.health = self.max_health

func set_health(new_health: int) -> void:
	self.health = new_health

func get_health() -> int:
	return health

func damage(amount: int) -> void:
	self.health -= amount
	
	if self.health < 0:
		emit_signal("died")
		get_parent().queue_free()
