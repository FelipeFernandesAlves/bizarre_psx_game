extends CharacterBody3D

@export_category("Properties")
@export var npc_id := "default"
@export var npc_name := "Fulano"
@export var quest : Global.quests = Global.quests.DEFAULT

@export_category("Dialogue")
@export var dialogue_resource : Dialogue
@export var dialogue_ui : DialogueUI
@export var can_interact: bool = true

@export_category("Item")
@export var item_name: String = ""
@export var item_dialogue_id: String = ""

@onready var head: CollisionShape3D = $head
@onready var coll_outline: MeshInstance3D = $coll_outline
@onready var npc_model:Node3D = $model.get_node(NodePath(name))

@onready var door_exit: AudioStreamPlayer3D = $door_exit
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
var current_on_target_reached = null
var SPEED = 6.0
var focused: bool:
	set(value):
		#coll_outline.visible = value
		focused = value

signal item_received()

func _ready() -> void:
	dialogue_resource.load_from_json("res://dialogue/dialogues.json")
	#coll_outline.visible = false
	npc_model.visible = true

func _physics_process(delta: float) -> void:                                     
	if not nav_agent.is_navigation_finished():
		var current_location = global_transform.origin
		var next_location = nav_agent.get_next_path_position()
		var direction = next_location - current_location
		var new_velocity = direction.normalized() * SPEED
		#if npc_model.state != "walking":
		npc_model.state = "walking"
		
		if direction.length() > 0.1:
			var target_rotation = atan2(direction.x, direction.z)
			rotation.y = lerp_angle(rotation.y, target_rotation, 5.0 * delta)
		
		velocity = velocity.move_toward(new_velocity, 0.25)
		move_and_slide()
		
func interact():
	var npc_dialogues := dialogue_resource.get_dialog(npc_id)
	if npc_dialogues.is_empty(): 
		npc_model.state = "idle"
		return
	else:
		npc_model.state = "talking"
	
	if (Global.current_quest != quest):
		var t = npc_dialogues.get("ramdom", [])
		if (t.size() > 0):
			var d = {
				"text": t[randi_range(0, t.size()-1)]
			}
			dialogue_ui.add_dialogue(d)
	else:
		dialogue_ui.add_dialogue(npc_dialogues["dialogues"])
	
func go_to(target_location, _on_target_reached):
	npc_model.state = "walking"
	if Global.pause:
		return
	
	current_on_target_reached = _on_target_reached
	nav_agent.target_position = target_location

func _on_navigation_agent_3d_target_reached() -> void:
	npc_model.state = "idle"
	if current_on_target_reached == null:
		return
		
	current_on_target_reached.call()
