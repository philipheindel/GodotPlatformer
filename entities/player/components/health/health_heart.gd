extends AnimatedSprite2D


@export var level: int = 2


func _ready():
	$".".animation = "0"


func hit():
	level -= 1
	$".".animation = str(level)
