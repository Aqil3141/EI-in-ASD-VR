extends Area3D

# Tracks which emotion is currently being displayed
var count = 0;
var emotions = ["Anger", "Fear", "Happy", "Sad"] #emotion nodes alongside this node
var emotion;

# Called when the node enters the scene
# Starts teacher animation, plays an intro sound, and reveals itself after a delay
#the delays are just quality of life improvements. I had been tinkering to get animations
#working and this was the result (bit basic so feel free to improve it)
func _ready() -> void:
	play_model_animation("Armature_004|mixamo_com|Layer0_001")
	await get_tree().create_timer(1.0).timeout
	get_node("/root/Tutorial_1/AudioStreamPlayer").play()
	await get_tree().create_timer(2.0).timeout
	self.visible = true

# Advances to the next emotion in the sequence by hiding the previous one
# and turning the next one visible (they're all in the same 3D positional space)
# After all of them had a turn, reveals the "Proceed" button to move on
func next():
	make_invisible(emotions[count%4])
	count = count + 1;
	make_visible(emotions[count%4])
	play_sound()
	if count >= 4:
		get_parent().get_node("Proceed").make_visible()

# Makes the specified emotion node visible
func make_visible(current_emotion):
	emotion = get_parent().get_node(current_emotion)
	emotion.visible = true
	
# Hides the specified emotion node
func make_invisible(current_emotion):
	emotion = get_parent().get_node(current_emotion)
	emotion.visible = false

# Plays a specified animation on the teacher NPC
func play_model_animation(animation):
	var model = get_node("/root/Tutorial_1/teacher")  # Adjust path as needed
	var anim_player = model.get_node("AnimationPlayer")  # Or path to AnimationTree
	#print(anim_player.get_animation_list()) #Check for all animation names
	model.play_and_pose(animation)

# Preloaded emotion-specific audio files to be played when an emotion is shown
var emotion_sounds = [
	preload("res://assets/audio/anger.mp3"),
	preload("res://assets/audio/fear.mp3"),
	preload("res://assets/audio/happiness.mp3"),
	preload("res://assets/audio/sad.mp3")
]

# Plays the appropriate sound for the current emotion
func play_sound():
	var player = get_parent().get_node("Emotion")
	player.volume_db = Globals.sound_volume
	player.stream = emotion_sounds[count % 4]
	player.play()

#This bit of code helps with button responsiveness
#(It's the feature where if you hover over a button it turns darker)
#Also includes the functionality of the Proceed and Restart buttons
@onready var raycast = get_node("/root/Tutorial_1/XROrigin3D/RightHandController/RayCast3D")
var mesh : MeshInstance3D = null;
var collider = null;
@onready var controller = get_node("/root/Tutorial_1/XROrigin3D/RightHandController")
func _physics_process(_delta):
	if raycast.is_colliding():
		collider = raycast.get_collider()
		
		if collider is CollisionObject3D:
			mesh = collider.get_node("MeshInstance3D")
			mesh.get_active_material(0).metallic = 1.5
		if (controller.is_button_pressed("trigger") or controller.is_button_pressed("select_button")):
			if collider and collider.name == "Proceed":
				if get_tree().current_scene.scene_file_path == "res://scenes/tutorial_scene_1.tscn":
					get_tree().change_scene_to_file("res://scenes/tutorial_scene_2.tscn")
				else:
					get_tree().change_scene_to_file("res://scenes/tutorial_scene_1.2.tscn")
			elif collider and collider.name == "Restart":
				if get_tree().current_scene.scene_file_path == "res://scenes/tutorial_scene_1.tscn":
					get_tree().change_scene_to_file("res://scenes/tutorial_scene_1.tscn")
				else:
					get_tree().change_scene_to_file("res://scenes/tutorial_scene_1.1.tscn")
	else:
		if mesh != null:
			mesh.get_active_material(0).metallic = 0
			
