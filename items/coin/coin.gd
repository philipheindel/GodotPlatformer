extends AnimatedSprite2D


@export_enum("Bronze", "Silver", "Gold", "Platinum") var coin_type: String = "Bronze"


var collected: bool = false


func _ready():
	$".".animation = coin_type.to_lower()
	$".".play()


func _process(delta):
	if collected and not $AudioStreamPlayer.playing:
		queue_free()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		collected = true
		$AudioStreamPlayer.play()
		body.add_coin()
		visible = false
