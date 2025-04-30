extends Node

const EMOTIONS = ["angry", "fear", "happy", "sad"]

const BASE_PATH = "res://images/"
var current_question: Dictionary

var target_emotion = "happy" #hardcode for now, change dynamically thru menus later
var image_pool = []
var current_round_images = []
var correct_remaining = 0

#change depending on how many images per subfolder there are. there MUST be the same amount
#of expression images PER FOLDER or this WILL break. - danb
#additionally, for now (might change later) ALL IMAGES ****MUST**** BE IN .JPG FORMAT.
#NOT JPEG, NOT PNG, NOT BMP, IT MUST BE IN .JPG!!!! -danb
const NUM_IMAGES_PER_SUBFOLDER = 4

func _ready():
	#seed RNG based on system time
	randomize()
	generate_image_pool()

#emotion will be passed in from an external array accessing globals that will use
#the target_emotion variable in globals

 
func generate_image_pool():
	image_pool.clear()
	
	for emotion in EMOTIONS:
		for i in NUM_IMAGES_PER_SUBFOLDER:
			var image_path = "%s%s/%s_%d.jpg" % [BASE_PATH, emotion, emotion, i]
			image_pool.append({
				"emotion": emotion,
				"image": image_path
			})
	
	image_pool.shuffle()

func generate_question():
	var prompt_emotion = EMOTIONS[randi() % EMOTIONS.size()]
	print(prompt_emotion)
	var options = []
	
	for emotion in EMOTIONS:
		var index = randi() % NUM_IMAGES_PER_SUBFOLDER
		
		
		#the reason why all images must be in .jpg
		#vvvvvv
		var image_path = "%s%s/%s_%d.jpg" % [BASE_PATH, emotion, emotion, index]
		options.append({
			"emotion": emotion,
			"image": image_path
		})
	
	#handy godot method to randomize an array :)
	options.shuffle()

	current_question = {
		"question": "Select the image that represents '%s'" % prompt_emotion,
		"answer": prompt_emotion,
		"options": options
	}
	
	return current_question
	
#TEMP hardcoded for testing; extract from JSON or dynamic code in globals later - danb

#var current_question = {
	#"question": "Click on the image that represents 'happiness'",
	#"answer": "happiness",
	#"options": [
		#{"emotion": "happiness", "image": "res://images/happy.png"},
		#{"emotion": "sadness", "image": "res://images/sad.png"},
		#{"emotion": "fear", "image": "res://images/fear.png"},
		#{"emotion": "anger", "image": "res://images/anger.png"}
	#]
#}
