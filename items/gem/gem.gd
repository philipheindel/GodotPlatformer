extends AnimatedSprite2D


@export_enum("Red", "Green", "Blue") var coin_type: String = "Blue"
@export var bounce: bool = true
@export var bounce_range: int = 2
@export var speed: float = 0.08


var collected: bool = false
var direction: int = 1
var bounce_max: int
var bounce_min: int


func _ready() -> void:
	bounce_max = position.y + bounce_range
	bounce_min = position.y + (bounce_range * -1)
	animation = coin_type.to_lower()
	play()


func _physics_process(delta) -> void:
	if not bounce:
		return
	if position.y >= bounce_max or position.y <= bounce_min:
		direction = direction * -1
	position.y = position.y + (speed * direction)


func _on_area_2d_body_entered(body) -> void:
	if body.name == "Player":
		collected = true
		#$AudioStreamPlayer.play()
		body.add_coin()
		visible = false
