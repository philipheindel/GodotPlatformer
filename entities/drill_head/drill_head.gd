extends Node2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta) -> void:
	return
	if not $CharacterBody2D.is_on_floor():
		$CharacterBody2D.velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("ui_accept") and $CharacterBody2D.is_on_floor():
		$CharacterBody2D.velocity.y = JUMP_VELOCITY
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		$CharacterBody2D.velocity.x = direction * SPEED
	else:
		$CharacterBody2D.velocity.x = move_toward($CharacterBody2D.velocity.x, 0, SPEED)

	$CharacterBody2D.move_and_slide()


func _on_area_2d_body_entered(body) -> void:
	if body.name == "Player":
		body.hurt()
