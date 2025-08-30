extends CharacterBody2D

# Player status
@export var health: HealthComponent
@export var speed: SpeedComponent

# Logic/util variables
var w_size: Vector2
var direction: Vector2
var fire_rate: float
var can_shoot: bool
var shoot_timer: Timer

# Load bullet scene
var bullet_scene: PackedScene = preload("res://Entities/Player/PlayerBullet/PlayerBullet.tscn")

# Run init
func _ready() -> void:
	# Variables init
	fire_rate = 5.0
	w_size = get_viewport_rect().size
	position = Vector2(float(w_size.x / 2), float(w_size.y / 1.3))
	
	# died signal from HealthComponent
	health.connect("died", Callable(self, "_on_player_died"))

	# Shoot firerate timer
	can_shoot = true
	shoot_timer = Timer.new()
	shoot_timer.wait_time = 1.0 / fire_rate
	shoot_timer.one_shot = false
	shoot_timer.connect("timeout", Callable(self, "_on_shoot_timer_timeout"))
	add_child(shoot_timer)
	shoot_timer.start()

# Run every frame
func _process(_delta: float) -> void:
	# Player inputs control
	direction = Input.get_vector("left", "right", "up", "down")

	if Input.is_action_pressed("shift"):
		speed.set_speed(1000)
	else:
		speed.set_speed(500)

	if Input.is_action_pressed("j"):
		if can_shoot:
			shoot()

	# Player moviment apply
	velocity = direction * speed.get_speed()
	move_and_slide()

# firerate callof
func _on_shoot_timer_timeout() -> void:
	can_shoot = true

# shoot and reset
func shoot() -> void:
	var bullet_instance: Object = bullet_scene.instantiate()
	bullet_instance.set_position(position)
	get_parent().add_child(bullet_instance)
	can_shoot = false

# This is dark souls
func _on_player_died() -> void:
	get_tree().change_scene_to_packed(load("res://Telas/Gameover/Gameover.tscn"))
