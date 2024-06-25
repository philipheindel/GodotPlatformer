extends Node2D


@export var max: int = 6
@export var current: int = 0


var health_heart: Resource = preload("res://entities/player/components/health/health_heart.tscn")


func _ready():
	var sub: int = max / 2
	for i in sub:
		var new_heart: AnimatedSprite2D = health_heart.instantiate()
		var abc = $Health_Heart.sprite_frames.get_frame_texture($Health_Heart.animation, $Health_Heart.frame).get_size()
		new_heart.position.x = new_heart.position.x + 20
		$".".add_child(new_heart)


func _update(health: int):
	
	pass
