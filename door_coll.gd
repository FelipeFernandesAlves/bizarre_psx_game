extends StaticBody3D

var can_interact: bool

func _ready() -> void:
	$CollisionShape3D.disabled = true

func interact():
	$AudioStreamPlayer3D.play()
	Global.player.dialogue_ui.add_dialogue({
		"text": [
			["", "Está trancada.."]
		]
	})
