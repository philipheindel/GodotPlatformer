extends StaticBody2D


@export var popped: bool = false


func _on_area_2d_body_entered(body):
	if popped:
		return
	if body.name == "Player":
		popped = true
		$AnimatedSprite2D.animation = "popped"
		# re-implement adding a coin to the current root scene
