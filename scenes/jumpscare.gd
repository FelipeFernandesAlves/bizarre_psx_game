extends Control

@onready var jumpscare: Control = $Jumpscare
var waiting_time := 2.65
var can_transition: bool

func _ready() -> void:
	jumpscare.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(jumpscare, "modulate:a", 1.0, 0.25)

func _process(delta: float) -> void:
	waiting_time -= delta
	
	if waiting_time <= 0 && !can_transition:
		Transition.fade_in(2, func():
			await get_tree().create_timer(2).timeout
			get_tree().change_scene_to_file("res://scenes/Credits.tscn")
			)
		can_transition = true
