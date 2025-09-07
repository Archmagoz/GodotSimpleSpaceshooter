extends Node2D
class_name SpeedComponent

# Configuração no editor
@export var speed_max: float
@export var speed_min: float

# Velocidade atual (getter/setter)
var speed: float

func _ready() -> void:
	speed = speed_min

func speed_inc(amount: float, delta: float) -> void:
	speed = clamp(speed + amount * delta, speed_min, speed_max)

func speed_dec(amount: float, delta: float) -> void:
	speed = clamp(speed - amount * delta, speed_min, speed_max)

func set_speed(new_speed: float) -> void:
	speed = clamp(new_speed, speed_min, speed_max)

func get_speed() -> float:
	return speed

func get_speed_max() -> float:
	return speed_max
