class_name DialogueOption extends MarginContainer

@onready var selected_icon: TextureRect = $MarginContainer/HBoxContainer/SelectedIcon
@onready var label: Label = $MarginContainer/HBoxContainer/Label

var text: String:
	set(value):
		text = value
		if (label != null):
			label.text = value

var selected: bool = false:
	set(value):
		selected = value
		if (selected_icon != null):
			selected_icon.visible = value

func _ready() -> void:
	selected_icon.visible = selected
	label.text = text
