extends Area2D

# Ufo load shoot scene
const BULLET_SCENE: PackedScene = preload("res://Entities/Enemy/Ufo/UfoBullet/UfoBullet.tscn")

# Ufo stats
@export var health: HealthComponent
@export var speed: SpeedComponent

# Logic/util variables
var direction: int = 1
var fire_timer: Timer

func _ready() -> void:
	# Init position
	position = Vector2(Game.w_size.x / 2.0, Game.w_size.y / 7.0)
	
	# Random firerate
	fire_timer = Timer.new()
	_set_random_fire_rate()
	fire_timer.one_shot = false
	fire_timer.timeout.connect(_on_fire_timeout)
	add_child(fire_timer)
	fire_timer.start()

func _physics_process(delta: float) -> void:
	# Acceleration
	if speed.get_speed() < speed.get_speed_max():
		speed.speed_inc(100, delta)

	# Move UFO
	position += Vector2.RIGHT * direction * speed.get_speed() * delta

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Borders":
		direction *= -1

func _on_fire_timeout() -> void:
	_set_random_fire_rate()
	var bullet_instance: Object = BULLET_SCENE.instantiate()
	bullet_instance.position = position
	get_tree().current_scene.add_child(bullet_instance)

func _set_random_fire_rate() -> void:
	fire_timer.wait_time = randf_range(0.2, 2.0)

func _on_ufo_died() -> void:
	queue_free()
