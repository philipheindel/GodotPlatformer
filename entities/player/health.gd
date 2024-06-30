extends Node2D


func update(health: int) -> void:
	var max_health: int = 0
	for point in range(1, 5):
		get_node("Heart_" + str(point)).animation = "0"
		max_health += 2
	
	var index: int = 1
	for point in health:
		var current_heart = get_node("Heart_" + str(index))
		if (point % 2) == 0 and point != 0:
			index += 1
	
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
