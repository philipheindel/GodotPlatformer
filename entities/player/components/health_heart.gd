extends AnimatedSprite2D


@export var level: int = 2


func _ready():
	$".".animation = str(level)


func hit():
	level -= 1
	$".".animation = str(level)
