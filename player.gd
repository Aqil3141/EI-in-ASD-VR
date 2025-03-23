extends XROrigin3D

@export var move_speed := 5.0
@export var look_sensitivity := 0.2

var camera : Camera3D
var mouse_captured := false

func _ready():
	camera = $Camera3D  # Make sure you have a Camera3D child node
	capture_mouse()

func _input(event):
	# Mouse look
	if event is InputEventMouseMotion and mouse_captured:
		rotate_y(deg_to_rad(-event.relative.x * look_sensitivity))
		

	# 'Esc' to exit game
	if Input.is_action_just_pressed("ui_cancel"):
		if mouse_captured:
			release_mouse()
		else:
			capture_mouse()

func _process(delta):
	# Keyboard movement
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var move_dir = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	position += move_dir * move_speed * delta

#check if mouse is in active use
func capture_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true

func release_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false
