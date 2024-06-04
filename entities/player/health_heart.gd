extends Node2D


const POSITION_OFFSET: int = 19


@export var health: int = 6


var hearts: Array[AnimatedSprite2D] = []


func _ready():
	hearts.append($Heart_1)
	var index: int = 1
	for h in range(2, health, 2):
		var new_heart: AnimatedSprite2D = $Heart_1.duplicate()
		new_heart.position.x = ($Heart_1.position.x + (POSITION_OFFSET * index))
		$".".add_child(new_heart)
		hearts.append($Heart_1.duplicate())
		
		index += 1


func hit():
	health -= 1
	var heart_index: int = 1
	for h in range(0, health):
		
		heart_index += 1
