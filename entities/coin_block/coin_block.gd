extends Node2D


@export_enum("Bronze", "Silver", "Gold", "Platinum") var coin_type: String = "Bronze"
@export var popped: bool = false
@export var coin_pop_offset: int = 20


var popping: bool = false
var done: bool = false


func _ready() -> void:
	$Coin.update_animation(coin_type.to_lower())


func _on_area_2d_body_entered(body) -> void:
	if popped or popping or done:
		# Play "thud" sound
		return
	if body.name == "Player":
		popping = true
		$AudioStreamPlayer.play()
		$AnimationPlayer.play("pop")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if popped:
		popped = false
		done = true
		return
	if popping:
		popping = false
		popped = true
		$RigidBody2D/AnimatedSprite2D.animation = "popped"
		$Coin.position = Vector2($RigidBody2D.position.x, $RigidBody2D.position.y - coin_pop_offset)
		$AnimationPlayer.play_backwards("pop")
		return
