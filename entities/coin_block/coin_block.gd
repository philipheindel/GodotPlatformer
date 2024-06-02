extends StaticBody2D


@export var popped: bool = false
@export var coin_pop_offset: int = 20


var popping: bool = false
var pop_direction: int = -1
var max_pop_frames: int = 5
var pop_frames: int = 0


func _physics_process(delta):
	if popped:
		return
	if popping:
		pop_frames += 1
		position.y = position.y + pop_direction
		if pop_frames == max_pop_frames and pop_direction > 0:
			$".".remove_child($Area2D)
			popped = true
			return
		if pop_frames == max_pop_frames:
			$AnimatedSprite2D.animation = "popped"
			var new_coin: AnimatedSprite2D = load("res://items/coin/coin.tscn").instantiate()
			new_coin.position = Vector2(position.x, position.y - coin_pop_offset)
			get_tree().get_root().call_deferred("add_child", new_coin)
			pop_direction = pop_direction * pop_direction
			pop_frames = 0


func _on_area_2d_body_entered(body):
	if popped or popping:
		return
	if body.name == "Player":
		$AudioStreamPlayer.play()
		popping = true
