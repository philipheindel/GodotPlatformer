extends AnimatedSprite2D


var collected: bool = false


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		collected = true
		body.coin_count += 1
		queue_free()
