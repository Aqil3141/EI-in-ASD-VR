extends Node
const EMOTIONS = ["angry", "fear", "happy", "sad"]
const avatar = {"angry":"😠", "fear":"😱", "happy":"😃", "sad":"😞"}
const BASE_PATH = "res://assets/images/"
var username: String = ""
var current_question: Dictionary
#music and sound settings
var music_volume = 0.01;
var sound_volume = 0.01;

#hand color settings
var hand_color = Color("#E89F63") 




#change depending on how many images per subfolder there are. there MUST be the same amount
#of expression images PER FOLDER or this WILL break. - danb
#additionally, for now (might change later) ALL IMAGES ****MUST**** BE IN .JPG FORMAT.
#NOT JPEG, NOT PNG, NOT BMP, IT MUST BE IN .JPG!!!! -danb
const NUM_IMAGES_PER_SUBFOLDER = 6

func _ready():
	#seed RNG based on system time
	randomize()
	
func generate_question():
	var scene = false
	if get_tree().get_current_scene().has_node("Tutorial_1_2") or get_tree().get_current_scene().has_node("Tutorial_1_1"):
		scene = true
	
	var prompt_emotion = EMOTIONS[randi() % EMOTIONS.size()]
	while current_question and prompt_emotion == current_question["answer"]:
		prompt_emotion = EMOTIONS[randi() % EMOTIONS.size()]
	
	var options = []
	
	for emotion in EMOTIONS:
		var index = randi() % (NUM_IMAGES_PER_SUBFOLDER if !scene else 4)
		
		
		#the reason why all images must be in .jpg
		#vvvvvv
		var image_path = "%s%s/%s_%d.jpg" % [BASE_PATH, emotion, (emotion if !scene else "basic"), index]
		options.append({
			"emotion": emotion,
			"image": image_path
		})
	
	#handy godot method to randomize an array :)
	options.shuffle()

	current_question = {
		"question": "Select the image that represents '%s' %s" % [prompt_emotion, avatar[prompt_emotion]],
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

func set_hand_color(value):
	hand_color = value

func get_hand_color():
	return hand_color
