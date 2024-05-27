extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -200.0


@export_enum("Blue", "Green", "Pink", "Yellow") var player_type: String = "Green"


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var walking: bool = false
var falling: bool = false


func _ready():
	$AnimatedSprite2D.animation = _get_animation("idle")
	$AnimatedSprite2D.play()


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_accept")): # and is_on_floor():
		print(velocity.y)
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


func _get_animation(animation: String) -> String:
	return "{player_type}_{animation}".format({"player_type": player_type, "animation": animation}).to_lower()
