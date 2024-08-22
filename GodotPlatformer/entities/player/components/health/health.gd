extends Node2D


@export var health_max: int = 10


var position_offset: int = 0
var health_heart: Resource = preload("res://entities/player/components/health/health_heart.tscn")


func _ready() -> void:
	var hearts: int = health_max / 2
	for i in hearts:
		var new_heart: AnimatedSprite2D = health_heart.instantiate()
		new_heart.position.x = new_heart.position.x + position_offset
		add_child(new_heart)
		position_offset += 18


func update(health: int) -> void:
	var amount: int = 0
	for heart in get_children():
		heart.animation = "0"
		if amount >= health:
			continue
		if amount < health:
			heart.animation = "1"
			amount += 1
		if amount < health:
			heart.animation = "2"
			amount += 1
