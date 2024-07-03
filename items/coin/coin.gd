extends Node2D


@export_enum("Bronze", "Silver", "Gold", "Platinum") var coin_type: String = "Bronze"


func _ready() -> void:
	$Coin.play(coin_type.to_lower())


func _on_area_2d_body_entered(body) -> void:
	if body.name == "Player":
		$AudioStreamPlayer.play()
		$AnimationPlayer.play("collect")
		body.add_coin()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()


func update_animation(coin_type: String) -> void:
	$Coin.play(coin_type.to_lower())
