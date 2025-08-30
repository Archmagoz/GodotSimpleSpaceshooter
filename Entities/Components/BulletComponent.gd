extends Node2D

class_name BulletComponent

# Set on godot
@export var speed: SpeedComponent
@export var damage: int
@export var life_time: int

# Logic
var time_alive: float = 0.0
var health_component: HealthComponent

# Check collision with damagable object and give damage
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has_node("HealthComponent") and area != $Area2D:
		health_component = area.get_node("HealthComponent")
		if health_component:
			health_component.damage(damage)
			queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_node("HealthComponent"):
		health_component = body.get_node("HealthComponent")
		if health_component:
			health_component.damage(damage)
			queue_free()

# Travel and despaw
func _process(_delta: float) -> void:
	position.y -= speed.get_speed() * _delta

	time_alive += _delta
	if time_alive >= life_time:
		queue_free()
