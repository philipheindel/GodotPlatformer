extends AnimatedSprite2D


@export_enum("Red", "Green", "Blue") var coin_type: String = "Blue"


func _ready():
	$".".animation = coin_type.to_lower()
	$".".play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
