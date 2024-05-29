This is just a file for copying some of the gdscript code from an old platformer I had made in the web editor to the new platformer project. Most of it is just movement code, but I thought it could potentially be useful.

# coin_block.gd (from old project)
```py
extends StaticBody2D


var new_coin = preload("res://entities/items/coin.tscn")


@export var popped = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if popped:
		return
	if body == $"../Green_Player":
		popped = true
		var new_coin: AnimatedSprite2D = load("res://entities/items/coin.tscn").instantiate()
		new_coin.position = Vector2(position.x, position.y - 25)
		$"..".add_child(new_coin)
		
		$AnimatedSprite2D.animation = "popped"

```

# Green_Player.gd (from old project)
```py
extends CharacterBody2D


@export var health = 2
@export var speed = SPEED
@export var jump = JUMP_VELOCITY
@export var looking_left = true


const SPEED = 150.0
const JUMP_VELOCITY = -300.0


var coin_count = 0
var jumping = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	$Health_Value.text = str(health)
	$AnimatedSprite2D.flip_h = not looking_left


func _physics_process(delta):
	$Label.text = "x: " + str(velocity.x)
	$Label2.text = "y: " + str(velocity.y)
	$Label3.text = "jumping: " + str(jumping)
	if not is_on_floor():
		jumping = velocity.y < 0
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump

	var direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_pressed("ui_right"):
		looking_left = false
	elif Input.is_action_just_pressed("ui_left"):
		looking_left = true
	$AnimatedSprite2D.flip_h = not looking_left
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if velocity.x == 0 or not is_on_floor():
		$AnimatedSprite2D.animation = "default"
	else:
		$AnimatedSprite2D.animation = "walking"

	move_and_slide()


func hit():
	health = health - 1
	$Health_Heart.hit()
	if health <= 0:
		print("dead")


func collect_coin():
	coin_count += 1
	$Coins_Count.text = str(coin_count)


func is_jumping():
	return velocity.y < 0
```

# drill_head.gd (from old project)
```py
extends CharacterBody2D


@export var speed: float = WALK_SPEED
@export var wander_range: float = 50.0
@export var wander_direction: int = -1


const RUN_SPEED: float = 200.0
const WALK_SPEED: float = 20.0
const JUMP_VELOCITY: float = -400.0


var max_range: float = 0.0
var min_range: float = 0.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	max_range = position.x + wander_range
	min_range = position.x - wander_range


func _physics_process(delta):
	$AnimatedSprite2D.animation = "walking"
	if not is_on_floor():
		velocity.y += gravity * delta

	move()
	move_and_slide()


func move():
	if position.x > max_range or position.x < min_range:
		#velocity.x = 0
		wander_direction = wander_direction * -1
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
	velocity.x = WALK_SPEED * wander_direction


func _on_area_2d_body_entered(body):
	if body == $"../Green_Player":
		$"../Green_Player".hit()
```