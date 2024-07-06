extends CharacterBody2D


const SPEED: float = 200.0
const JUMP_VELOCITY: float = -300.0


@export_category("Character")
@export_enum("Blue", "Green", "Orange", "Pink", "Yellow") var player_type: String = "Green"
@export var coin_count: int = 0
@export var health: int = 8


@export_category("Movement")
@export_subgroup("Jumping")
@export var jump_peak_time: float = 0.5
@export var jump_fall_time: float = 0.5
@export var jump_height: float = 5.0
@export var jump_distance: float = 4.0
var speed: float = 5.0
var jump_velocity: float = 5.0
var jump_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var fall_gravity = 5.0

@export var max_jump_duration: float = 0.1
@export var do_inertia: bool = true


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var walking: bool = false
var falling: bool = false
var jump_total: float = 0.0


func _ready() -> void:
	_calculate_movement_params()
	$AnimatedSprite2D.animation = _get_animation("idle")
	$AnimatedSprite2D.play()
	$Camera2D.set_as_top_level(true)
	$Camera2D/Health.max = health
	print(jump_gravity)
	print(fall_gravity)
	print(jump_velocity)
	print("ready?")


func _process(_delta) -> void:
	$Camera2D.position.x = position.x
	#$Camera2D.position.x = $".".position.x
	if velocity.y != 0:
		#print(velocity.y)
		#print($Camera2D.position.y)
		$Camera2D.position.y = 0
	pass


func _physics_process(delta: float) -> void:
	print(velocity.y)
	print(gravity)
	print(jump_gravity)
	print(fall_gravity)
	print(delta)
	if not is_on_floor():
		#velocity.y += gravity * delta
		if velocity.y > 0:
			velocity.y -= jump_gravity * delta
		else:
			velocity.y -= fall_gravity * delta

	if (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_accept")) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if (Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_accept")) and not is_on_floor():
		falling = true

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		$AnimatedSprite2D.animation = _get_animation("walking")
		if direction == 1:
			$AnimatedSprite2D.flip_h = true
		elif direction == -1:
			$AnimatedSprite2D.flip_h = false
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.animation = _get_animation("idle")


	move_and_slide()
	return
	#print(velocity.y)
	if not is_on_floor():
		#velocity.y -= jump_gravity * delta
		if velocity.y > 0:
			velocity.y -= jump_gravity * delta
		else:
			velocity.y -= fall_gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity


	# https://www.youtube.com/watch?v=FvFx1R3p-aw
	#move_and_slide()
	#return
	if (Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_accept")) and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4
	
	if (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_accept")):
		velocity.y = JUMP_VELOCITY
	
	#var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		$AnimatedSprite2D.animation = _get_animation("walking")
		if direction == 1:
			$AnimatedSprite2D.flip_h = true
		elif direction == -1:
			$AnimatedSprite2D.flip_h = false
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.animation = _get_animation("idle")
	move_and_slide()
	return
	if not falling and (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_accept")):
		velocity.y = JUMP_VELOCITY * (jump_total * 10)
		jump_total += delta
		if jump_total >= max_jump_duration:
			falling = true
			jump_total = 0.0
	
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		$AnimatedSprite2D.animation = _get_animation("walking")
		if direction == 1:
			$AnimatedSprite2D.flip_h = true
		elif direction == -1:
			$AnimatedSprite2D.flip_h = false
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.animation = _get_animation("idle")
	
	if Input.is_action_pressed("ui_down") and is_on_floor():
		velocity = Vector2(-600.0, -200.0)
	
	move_and_slide()
	for i in get_slide_collision_count():
		var collider_name: String = get_slide_collision(i).get_collider().name
		if collider_name != "TileMap":
			#print(collider_name)
			pass


func add_coin() -> void:
	coin_count += 1


func hurt() -> void:
	health -= 1
	$Camera2D/Health.update(health)
	if health == 0:
		print("Dead")


func _get_animation(animation: String) -> String:
	return "{player_type}_{animation}".format({"player_type": player_type, "animation": animation}).to_lower()

func _calculate_movement_params() -> void:
	jump_gravity = (2 * (jump_height * 100)) / pow(jump_peak_time, 2)
	fall_gravity = (2 * (jump_height * 100)) / pow(jump_fall_time, 2)
	jump_velocity = jump_gravity * jump_peak_time
