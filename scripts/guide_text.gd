extends Node3D

# Called when the node is added to the scene.
# Connects to the parent's "result_checked" signal and plays the default starting animation.
func _ready():
	get_parent().connect("result_checked", Callable(self, "_on_result_checked"))
	play_model_animation("Armature|mixamo_com|Layer0")

# Called when the parent emits the "result_checked" signal after a quiz/tutorial is completed.
# Displays feedback based on the score, triggers animations, plays audio, and reveals progression buttons.
func _on_result_checked(count: String):
	#internal count used from Button_Options.gd
	if int(count) < 4:
		self.text = tr("Good job!") + " " + count + "/4"
	if int(count) == 4:
		self.font_size = 16
		self.text = tr("Wonderful! You have finished the tutorial")
		self.text += "\n"
		self.text += tr("Click on the 'Proceed' button to move to the next stage")
		play_model_animation("Armature_003|mixamo_com|Layer0_002") #Have the NPC teacher move
		$AudioStreamPlayer.play() #Play the audio cue
		#Make buttons appear in front of player
		#get_parent().turn_off()
		get_parent().get_node("Proceed").make_visible()
		get_parent().get_node("Restart").make_visible()

# Plays a given animation on the teacher NPC character.
# The teacher would have a node that has a custom `play_and_pose()` method that handles animation logic.
func play_model_animation(animation):
	var model = get_node("/root/Main/teacher")  # Adjust path as needed
	var anim_player = model.get_node("AnimationPlayer")  # Or path to AnimationTree
	#print(anim_player.get_animation_list()) #Check for all animation names
	model.play_and_pose(animation)
