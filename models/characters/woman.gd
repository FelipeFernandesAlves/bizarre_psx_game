extends Node3D

@export var state := "idle"

func _process(_delta: float) -> void:
	match state:
		"idle": set_idle()
		"walking": set_walking()
		"talking": set_talking()

func set_idle():
	$AnimationPlayer.play("loop_dancing")

func set_talking():
	pass
	
func set_walking():
	pass
