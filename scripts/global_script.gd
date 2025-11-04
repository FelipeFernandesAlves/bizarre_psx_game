extends Node

var ui_context : ContextComponent
var player : Player
var camera : Camera3D
var hud : Control
var pause := false

enum quests {
	DEFAULT,
	TRASH,
	NPC1,
	NPC2,
	CLEAN
}

var current_quest: quests = quests.NPC2

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("fullscreen")):
		if (get_window().mode == Window.MODE_WINDOWED):
			get_window().mode = Window.MODE_FULLSCREEN
		else:
			get_window().mode = Window.MODE_WINDOWED
			
