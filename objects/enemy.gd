extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

@onready var controller = get_parent()

var SPEED = 7

func _physics_process(delta: float) -> void:
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var direction = (next_location - current_location)
	var new_velocity = direction.normalized() * SPEED
	
	if direction.length() > 0.1:
		var target_rotation = atan2(direction.x, direction.z)
		rotation.y = lerp_angle(rotation.y, target_rotation, 5.0 * delta)
	
	velocity = velocity.move_toward(new_velocity, 0.25)
	move_and_slide()

func update_target_location(target_location):
	nav_agent.target_position = target_location
	nav_agent.get_next_path_position()

func _on_navigation_agent_3d_target_reached() -> void:
	if controller:
		controller.emit_signal("Jumpscare")
