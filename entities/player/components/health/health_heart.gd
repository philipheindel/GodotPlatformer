extends AnimatedSprite2D


@export var level: int = 2


func _ready() -> void:
	animation = "2"


func hit() -> void:
	level -= 1
	animation = str(level)
