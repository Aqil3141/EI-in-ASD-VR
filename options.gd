extends Node3D

var controller = null
var current_question = Globals.generate_question()

#
#func set_controller(ctrl):
	#controller = ctrl
	#controller.set_question_data(current_question)

func _ready():
	$CurrentQuestion.text = current_question["question"]
	
	var options = current_question["options"].duplicate()
	
	var main = get_parent()
	
	#problem is likely because it is trying to access XROrigin3D/righthandcontroller
	#specifically within the main.tscn working tree
	#figure out a way to get it to reference righthandcontroller while it is within its own scene
	#print(controller)
	#controller.set_question_data(current_question)

	#randomise order of options
	options.shuffle()
	
	#for i in range(options.size()):
	for i in range(2):
		#retrieve option panels depending on the current loop index
		var panel = get_node("Option_%d" % i)
		print("Option_%d"%i)
		var emotion_data = options[i]
		
		#assign texture
		var material := StandardMaterial3D.new()
		print("loading image: ", emotion_data["image"])
		var texture = load(emotion_data["image"])
		print("Loaded texture: ", texture)
		
		material.albedo_texture = load(emotion_data["image"])
		
		#inline operation to find the first MeshInstance3D node of Option_%d so that the names
		#aren't different
		var mesh = panel.get_children().filter(func(c): return c is MeshInstance3D).front()
		
		mesh.set_surface_override_material(0, material)
		
		#store data within the option_%d object so that the raycast controller can retrieve it.
		panel.set_meta("emotion", emotion_data["emotion"])
		
