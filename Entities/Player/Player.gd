extends CharacterBody2D

# Preload Scenes
const BULLET_SCENE: PackedScene = preload("res://Entities/Player/PlayerBullet/PlayerBullet.tscn")

# Player status
@export var health: HealthComponent
@export var speed: SpeedComponent

# Logic/util variables
var tree: SceneTree
var fire_rate: float = 5.0
var can_shoot: bool = true
var direction: Vector2
var shoot_timer: Timer
var current_speed: float

# Function call on object instanciate
func _ready() -> void:
	# Init position
	position = Vector2(Game.w_size.x / 2.0, Game.w_size.y / 1.3)
	current_speed = speed.get_speed()

	# Shoot firerate timer
	shoot_timer = Timer.new()
	shoot_timer.wait_time = 1.0 / fire_rate
	shoot_timer.one_shot = false
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	add_child(shoot_timer)
	shoot_timer.start()
	
	tree = get_tree()

# Run every frame
func _physics_process(_delta: float) -> void:
	_handle_movement()
	_handle_shoot()

# Basic moviment func
func _handle_movement() -> void:
	direction = Input.get_vector("left", "right", "up", "down")

	# Shift speed control
	speed.set_speed(1000 if Input.is_action_pressed("shift") else 500)
	
	# Apply movement
	velocity = direction * speed.get_speed()
	move_and_slide()

# Basic shoot and shoot firerate func
func _on_shoot_timer_timeout() -> void:
	can_shoot = true

func _handle_shoot() -> void:
	if Input.is_action_pressed("j") and can_shoot:
		var bullet_instance: Node2D = BULLET_SCENE.instantiate()
		bullet_instance.position = position
		get_parent().add_child(bullet_instance)
		can_shoot = false

# Press F to pay respect
func _on_player_died() -> void:
	call_deferred("_die")

func _die() -> void:
	Game.gameover(tree)
