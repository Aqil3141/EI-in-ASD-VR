extends Node3D

#node references
@onready var raycast := $XROrigin3D/RightHandController/RayCast3D
@onready var screen_viewport := $SubViewport 
@onready var screen_mesh := $MeshInstance3D  

# The resolution of the SubViewport. Should match the actual Viewport size.
@export var screen_size := Vector2(1156, 512) 

# Called every physics frame
# Detects if the raycast is hitting the UI screen mesh and simulates mouse interaction
func _physics_process(delta):
	if raycast.is_colliding():
		var collider = raycast.get_collider()

		if collider.name == "StaticBody3D":
			var hit_pos = raycast.get_collision_point()

			var uv = get_uv_from_hit(hit_pos)

			simulate_mouse_on_viewport(uv)

func get_uv_from_hit(hit_pos: Vector3) -> Vector2:
	var local_hit = screen_mesh.to_local(hit_pos)
	#print("Local hit position: ", local_hit)

	var x_normalized = (local_hit.x + 1.0) / 2.0
	var y_normalized = (local_hit.z + 0.5) / 1.0 - 0.03500

	var uv = Vector2(x_normalized, y_normalized)
	#print("UV from local hit: ", uv)

	return uv.clamp(Vector2.ZERO, Vector2.ONE)

func simulate_mouse_on_viewport(uv: Vector2) -> void:
	var viewport_size = screen_viewport.size
	var pixel_pos = uv * Vector2(viewport_size.x, viewport_size.y)


	#print("Simulating mouse at pixel position: ", pixel_pos)
	var event = InputEventMouseMotion.new() 
	if $XROrigin3D/RightHandController.is_button_pressed("trigger") or $XROrigin3D/RightHandController.is_button_pressed("select_button"):
		event = InputEventMouseButton.new()
		event.button_index = MOUSE_BUTTON_LEFT
		event.pressed = true
		event.position = pixel_pos
		event.global_position = pixel_pos
		event.button_mask = MOUSE_BUTTON_MASK_LEFT
	else:
		event.position = pixel_pos
		event.relative = Vector2.ZERO
		event.button_mask = 0
		event.global_position = pixel_pos
	
	# Send the input event to the 2D Viewport for UI interaction
	screen_viewport.push_input(event, true)
