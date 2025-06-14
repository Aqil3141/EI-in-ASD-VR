extends Node3D
#Test script for future development maybe
#When using VR the height is a bit whack as taller players
#may see the world differently from shorter players
#this script was made to fix that however it is not part of the current version

# Attach to CameraRig (parent of the camera)
@export var fixed_y := 0.5  # Desired eye height in meters

func _process(_delta):
	var camera = $XRCamera3D
	var offset = camera.transform.origin
	# Apply inverse Y offset to cancel vertical movement
	offset.y = -offset.y + fixed_y
	transform.origin = offset
