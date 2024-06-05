extends Node2D


var hearts: Array[AnimatedSprite2D] = [$Heart_1, $Heart_2, $Heart_3, $Heart_4]


func update(health: int):
	$Heart_1.animation = "0"
	$Heart_2.animation = "0"
	$Heart_3.animation = "0"
	$Heart_4.animation = "0"
	if health > 0:
		$Heart_1.animation = "1"
	if health > 1:
		$Heart_1.animation = "2"
	if health > 2:
		$Heart_2.animation = "1"
	if health > 3:
		$Heart_2.animation = "2"
	if health > 4:
		$Heart_3.animation = "1"
	if health > 5:
		$Heart_3.animation = "2"
	if health > 6:
		$Heart_4.animation = "1"
	if health > 7:
		$Heart_4.animation = "2"
