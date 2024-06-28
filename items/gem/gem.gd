extends AnimatedSprite2D


@export_enum("Red", "Green", "Blue") var coin_type: String = "Blue"


var collected: bool = false


func _ready():
	$".".animation = coin_type.to_lower()
	$".".play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		collected = true
		#$AudioStreamPlayer.play()
		body.add_coin()
		visible = false
