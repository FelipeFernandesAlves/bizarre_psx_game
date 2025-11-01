extends CharacterBody3D

@export_category("Properties")
@export var npc_id := "default"
@export var npc_name := "Fulano"

@export_category("Dialog")
@export var dialog_resource : Dialog
@export var dialog_ui : Control

@onready var head: CollisionShape3D = $head

func _ready() -> void:
	dialog_resource.load_from_json("res://dialogue/dialogues.json")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func interact():
	var npc_dialogs = dialog_resource.get_npc_dialog(npc_id)
	if npc_dialogs.is_empty(): return
	
	Global.player.focus = head
	dialog_ui.add_dialog(npc_name, npc_dialogs["dialogues"]["text"], [])
