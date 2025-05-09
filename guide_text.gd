extends Node3D

func _ready():
	get_parent().connect("result_checked", Callable(self, "_on_result_checked"))
	play_model_animation("Armature|mixamo_com|Layer0")

func _on_result_checked(count: String):
	if int(count) < 4:
		self.text = "Good job! " + count + "/4"
	if int(count) >= 4:
		self.font_size = 16
		self.text = "Wonderful! You have finished the tutorial"
		self.text += "\nClick on the 'Proceed' button to move to the next stage"
		play_model_animation("Armature_003|mixamo_com|Layer0_002")
		get_parent().get_node("Proceed").make_visible()
		get_parent().get_node("Restart").make_visible()

func play_model_animation(animation):
	var model = get_node("/root/Main/teacher")  # Adjust path as needed
	var anim_player = model.get_node("AnimationPlayer")  # Or path to AnimationTree
	#print(anim_player.get_animation_list()) #Check for all animation names
	model.play_and_pose(animation)
