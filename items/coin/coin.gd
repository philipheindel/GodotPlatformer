extends Node2D


@export_enum("Bronze", "Silver", "Gold", "Platinum") var coin_type: String = "Bronze"


var collected: bool = false


func _ready() -> void:
	$Coin.play(coin_type.to_lower())


func _process(delta) -> void:
	if collected and not $AudioStreamPlayer.playing:
		queue_free()


func _on_area_2d_body_entered(body) -> void:
	if body.name == "Player":
		collected = true
		$AudioStreamPlayer.play()
		body.add_coin()
		visible = false


func update_animation(coin_type: String) -> void:
	$Coin.play(coin_type.to_lower())
