extends Area2D

# Ufo load shoot scene
var bullet_scene: PackedScene = preload("res://Entities/Enemy/Ufo/UfoBullet/UfoBullet.tscn")

# Ufo stats
@export var health: HealthComponent
@export var speed: SpeedComponent

# Logic/util variables
var w_size: Vector2
var direction: int
var fire_timer: Timer

# Run init
func _ready() -> void:
	# Variable init
	w_size = DisplayServer.window_get_size()
	position.x = float(w_size.x / 2)
	position.y = float(w_size.y / 7)
	direction = 1
	
	# Random firerate
	fire_timer = Timer.new()
	fire_timer.wait_time = randf_range(0.5, 2.0)
	fire_timer.one_shot = false
	add_child(fire_timer)
	fire_timer.connect("timeout", Callable(self, "_on_fire_timeout"))
	fire_timer.start()

# Check collision with level borders
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Borders":
		direction *= -1

# Run every frame
func _process(_delta: float) -> void:
	if speed.get_speed() < speed.get_speed_max():
		speed.speed_inc(100, _delta)

	position += Vector2.RIGHT * direction * speed.get_speed() * _delta

# Firerate function callof
func _on_fire_timeout() -> void:
	fire_timer.wait_time = randf_range(0.5, 2.0)
	var bullet_instance: Object = bullet_scene.instantiate()
	bullet_instance.set_position(position)
	get_parent().add_child(bullet_instance)

func _on_ufo_died() -> void:
	queue_free()
