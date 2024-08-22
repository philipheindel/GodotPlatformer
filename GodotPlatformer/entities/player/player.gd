extends CharacterBody2D


const SPEED: float = 200.0
const JUMP_VELOCITY: float = -350.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


@export_category("Character")
@export_enum("Blue", "Green", "Orange", "Pink", "Yellow") var player_type: String = "Green"
@export var coin_count: int = 0
@export var health: int = 8


@export_category("Movement")
@export_subgroup("Jumping")
@export var max_jump_duration: float = 0.1


func _ready() -> void:
	$AnimatedSprite2D.animation = _get_animation("idle")
	$AnimatedSprite2D.play()
	$Camera2D.set_as_top_level(true)
	$Camera2D/Health.health_max = health


func _process(_delta: float) -> void:
	$Camera2D.position.x = position.x
	if velocity.y != 0:
		$Camera2D.position.y = 0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_accept")) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if (Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_accept")) and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		$AnimatedSprite2D.animation = _get_animation("walking")
		if direction == 1:
			$AnimatedSprite2D.flip_h = true
		elif direction == -1:
			$AnimatedSprite2D.flip_h = false
		velocity.x = move_toward(velocity.x, direction * SPEED, delta * 750)	
	else:
		velocity.x = move_toward(velocity.x, 0, delta * 750)
		$AnimatedSprite2D.animation = _get_animation("idle")

	move_and_slide()


func add_coin() -> void:
	coin_count += 1


func hurt() -> void:
	health -= 1
	$Camera2D/Health.update(health)
	if health == 0:
		print("Dead")


func enable_camera(state: bool = true) -> void:
	$Camera2D.enabled = state
	$Camera2D.visible = state


func _get_animation(animation: String) -> String:
	return "{player_type}_{animation}".format({"player_type": player_type, "animation": animation}).to_lower()
