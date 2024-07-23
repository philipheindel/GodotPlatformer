extends Node2D


@export_enum("Red", "Green", "Blue") var gem_type: String = "Blue"
@export var bounce: bool = true


var collected: bool = false
var audio_done: bool = false
var animation_done: bool = false


func _ready() -> void:
	$AnimatedSprite2D.play(gem_type.to_lower())
	if bounce:
		$AnimationPlayer.play("bounce")


func _process(_delta: float) -> void:
	if audio_done and animation_done:
		queue_free()


func _on_area_2d_body_entered(body) -> void:
	if body.name == "Player":
		body.add_coin()
		collected = true
		$AnimatedSprite2D/Area2D.set_process(false)
		$AudioStreamPlayer.play()
		$AnimationPlayer.play("collect")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "collect" :
		animation_done = true


func _on_audio_stream_player_finished():
	audio_done = true
