extends RayCast3D

var mesh := ImmediateMesh.new()
var mesh_instance := MeshInstance3D.new()

func _ready():
	mesh_instance.mesh = mesh
	add_child(mesh_instance)
	mesh_instance.top_level = true

func _process(_delta):
	var right_hand = get_parent()
	var scene_root = right_hand.get_parent()  # adjust if needed

	var from = scene_root.global_transform * right_hand.transform.origin
	var local_target = Vector3(0.28, 0.669, -5)
	var to = scene_root.global_transform * (right_hand.transform * local_target)

	mesh.clear_surfaces()
	mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	mesh.surface_add_vertex(from)
	mesh.surface_add_vertex(to)
	mesh.surface_end()
