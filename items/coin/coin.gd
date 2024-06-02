extends AnimatedSprite2D


var collected: bool = false


func _physics_process(delta):
	if collected and not $AudioStreamPlayer.playing:
		queue_free()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		collected = true
		$AudioStreamPlayer.play()
		body.add_coin()
		visible = false
