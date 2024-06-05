extends Node2D


var hearts: Array[AnimatedSprite2D] = [$Heart_1, $Heart_2, $Heart_3, $Heart_4]


func update(health: int):
	for h in health:
		
		pass
	if health < 1:
		$Heart_1.animation = 0
