class_name ContextComponent extends Node

@export var icon : TextureRect
@export var context : Label
@export var default_icon : Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.ui_context = self
	reset()

func reset():
	context.text = ""

func update_text(new_text: String):
	context.text = new_text
