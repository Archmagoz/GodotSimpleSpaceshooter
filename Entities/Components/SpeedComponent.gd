extends Node2D

class_name SpeedComponent

# Set on godot compostion
@export var speed_max: float
@export var speed_min: float

# Logic variables
var speed: float

# Simple speed
func _ready() -> void:
	self.speed = self.speed_min

func speed_inc(amount: float, delta: float) -> void:
	if self.speed < speed_max:
		self.speed += amount * delta
	if self.speed > speed_max:
		self.speed = speed_max

func speed_dec(amount: float, delta: float) -> void:
	if self.speed > speed_min:
		self.speed -= amount * delta
	if self.speed < speed_min:
		self.speed = speed_min

func set_speed(new_speed: float) -> void:
	self.speed = new_speed

func get_speed() -> float:
	return self.speed

func get_speed_max() -> float:
	return self.speed_max
