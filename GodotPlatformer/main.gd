extends Node2D


func _ready():
	$Player.enable_camera(false)


func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://levels/level_1/level_1.tscn")
	
