extends Node3D

@export var state := "idle"

func _process(delta: float) -> void:
	match state:
		"idle": set_idle()
		"walking": set_walking()
		"talking": set_talking()


func set_idle():
	$AnimationPlayer.play("loop_dancing")

func set_talking():
	$AnimationPlayer.play("loop_idle")
	
func set_walking():
	$AnimationPlayer.play("loop_waking")
