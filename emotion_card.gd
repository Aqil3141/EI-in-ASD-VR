extends Node3D

@export var emotion_image: Texture2D
@export var is_correct: bool = false

func _ready():
	var mat := StandardMaterial3D.new()
	mat.albedo_texture = emotion_image
	$MeshInstance3D.material_override = mat

func _on_Area3D_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if is_correct:
			print("Correct match!")
		else:
			print("Try again.")



func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	pass # Replace with function body.
