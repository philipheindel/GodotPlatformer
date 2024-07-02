extends Node2D


@export_enum("Red", "Green", "Blue") var gem_type: String = "Blue"
@export var bounce: bool = true


var collected: bool = false


func _ready() -> void:
	$AnimatedSprite2D.play(gem_type.to_lower())
	if bounce:
		$AnimationPlayer.play("bounce")


func _on_area_2d_body_entered(body) -> void:
	if body.name == "Player":
		collected = true
		#$AudioStreamPlayer.play()
		body.add_coin()
		visible = false
