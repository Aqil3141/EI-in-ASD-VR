extends Node3D

# Attach to CameraRig (parent of the camera)
@export var fixed_y := 0.5  # Desired eye height in meters

func _process(_delta):
	var camera = $XRCamera3D
	var offset = camera.transform.origin
	# Apply inverse Y offset to cancel vertical movement
	offset.y = -offset.y + fixed_y
	transform.origin = offset
