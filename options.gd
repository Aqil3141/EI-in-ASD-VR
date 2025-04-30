extends Node3D

var controller = null
var current_question = Globals.generate_question()

#
#func set_controller(ctrl):
	#controller = ctrl
	#controller.set_question_data(current_question)

#upon the start of the stage, retrieve images from the target emotion
#target emotion will be changed dynamicall thru menu screen - danb
func start_stage():
	var all_images = preload_images_for_emotion(Globals.target_emotion)
	#distractors are the images that are not the target emotion; selecting them will be wrong
	var distractors = preload_distractors(Globals.target_emotion)
	
	#create the image pool and randomise the order
	Globals.image_pool = all_images + distractors
	Globals.image_pool.shuffle()
	Globals.correct_remaining = all_images.size()
	
	
func show_next_round():
	if Globals.image_pool.size() == 0:
		print("Complete!")
		return
	
	# clear current round
	Globals.current_round_images.clear()
	
	#select 2 correct images
	for i in range(2):
		if Globals.image_pool.size() > 0:
			Globals.current_round_images.append(Globals.image_pool.pop_front())
	
	# select 4 random distractors (incorrect images)
	var distractors = preload_distractors(Globals.target_emotion)
	distractors.shuffle()
	for i in range(4):
		if i < distractors.size():
			Globals.current_round_images.append(distractors[i])
	
	#shuffle correct and incorrect images so that they are mixed and not next to each otehr
	Globals.current_round_images.shuffle()
	
	display_options(Globals.current_round_images)
	
	#range is 2 because there are two correct matching faces before advancing to the next round
	#there are 6 faces total, 4 incorrect and 2 correct -danb
	Globals.current_round_images = []
	for i in range(2):
		if Globals.image_pool.size() > 0:
				Globals.current_round_images.append(Globals.image_pool.pop_front())
	
	for i in range(2):
		var panel = get_node("Option_%d" % i)
		var data = Globals.current_round_images[i]
			


	
func preload_images_for_emotion(emotion: String) -> Array:
	var images = []
	for i in range(4):
		images.append({
			"image": "res://images/%s/%s_%d.jpg" % [emotion, emotion, i],
			"emotion": emotion
		})
	return images
	
func preload_distractors(correct_emotion: String) -> Array:
	const EMOTIONS = ["angry", "fear", "happy", "sad"]
	var distractors = []
	
	for emotion in EMOTIONS:
		if emotion == correct_emotion:
			continue
		for i in range(2):
			distractors.append({
				"image": "res://images/%s/%s_%d.jpg" % [emotion, emotion, i],
				"emotion": emotion
			})
	return distractors
	

func display_options(options: Array) -> void:
	for i in range(options.size()):
		var panel_path = "Option_%d" % i
		if not has_node(panel_path):
			push_error("Panel %s does not exist!" % panel_path)
			continue
		var panel = get_node(panel_path)
		var emotion_data = options[i]
		var image_path = emotion_data.get("image", "")
		
		print("Setting %s with image %s" % [panel_path, image_path])
		
		var texture = load(image_path)
		#adding this here in case something happens iwth the image pathing
		if texture == null:
			push_error("failed to load tex %s" % image_path)
		
		#assign texture
		var material := StandardMaterial3D.new()
		material.albedo_texture = texture
		
		#one meshinstance3d per panel!!!
		var mesh = panel.get_children().filter(func(c): return c is MeshInstance3D).front()
		if mesh:
			mesh.set_surface_override_material(0, material)
		else:
			#if no mesh push error
			push_error("no meshinstance3d")
		
		#store data within the option_%d object so that the raycast controller can retrieve it.
		panel.set_meta("emotion", emotion_data.get("emotion"))
		print(emotion_data)

func _ready():
	$CurrentQuestion.text = current_question["question"]
	
	start_stage()
	var options = Globals.image_pool
	display_options(options)

		
