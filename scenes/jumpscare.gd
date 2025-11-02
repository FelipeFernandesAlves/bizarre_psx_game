extends Node2D

var waiting_time = 17.0
@onready var jumpscare: Sprite2D = $Jumpscare

func _process(delta: float) -> void:
	waiting_time -= delta
	
	if waiting_time <= 7:
		jumpscare.modulate.v -= 0.01
	
	if waiting_time <= 0:
		get_tree().change_scene_to_file("res://scenes/Credits.tscn")
