extends Node2D


@export_enum("Bronze", "Silver", "Gold", "Platinum") var coin_type: String = "Bronze"
@export var popped: bool = false
@export var coin_pop_offset: int = 20


func _ready() -> void:
	$Coin.update_animation(coin_type.to_lower())


func _on_area_2d_body_entered(body) -> void:
	if body.name == "Player":
		$AudioStreamPlayer.play()
		$AnimationPlayer.play("pop")
		$RigidBody2D/Area2D.queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if popped:
		return
	popped = true
	$Coin.position = Vector2($RigidBody2D.position.x, $RigidBody2D.position.y - coin_pop_offset)
	$AnimationPlayer.play_backwards("pop")
