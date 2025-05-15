#edited by: danb,
extends XRController3D

#dependency injection TODO figure out how this works.

#potential fix to this issue is creating a global variable
var current_question
var select_next;

#depricated remove
func set_question_data(q):
	current_question = q

var targetObject = null
#

#detects if button is controller simulator button is pressed
func _ready() -> void:
	connect("button_pressed", btnPressedLeft)
	#re-define current_question in _ready() as otherwise it will initialise before the game has loaded in.
	current_question = Globals.current_question
	if get_tree().get_current_scene().name == "Tutorial_1":
		select_next = get_tree().get_current_scene().get_node("Selection/Next");
var label_node: Label3D = null
func set_label_node(label: Label3D):
#from here
	label_node = label

func next_question():
	#var options = get_node("/root/Main/Options")
	var options;
	options = get_parent().get_parent().get_node("Options") #IMPORTANT: Since XROrigin3D is supposed to be a child of selction.tscn this works
	options.generate_new_question()
	options.display_pictures()
	current_question = Globals.current_question
	
	
func play_sound(sound:String):
	var sound_file = "res://audio/"+sound+".mp3"
	$AudioStreamPlayer.stream = load(sound_file)
	$AudioStreamPlayer.play()

func check_answer(selected: String):
	var correct = current_question["answer"]
	$AudioStreamPlayer.volume_db = linear_to_db(Globals.sound_volume)
	#print("The answer is:" + correct)
	#var main = get_parent()
	#var label = main.get_node("")
	if selected == correct:
		play_sound("correct")
		return 1 #correct
	else:
		play_sound("Wrong")
		return 0 #incorrect
	

func _physics_process(_delta: float) -> void:
	if $RayCast3D.is_colliding():
		var c = $RayCast3D.get_collider()
		targetObject = c
		#prints name of raycasted object
		if targetObject:
			#print(targetObject.name)
			pass
	else:
		targetObject = null
	
	#
	#if $RayCast3D.is_colliding() && Input.is_action_just_pressed("trigger_click"):
		#var hit = $RayCast3D.get_collider()
		#
		##use this statement for any universal trigger click events, 
		##and define which object meta depending on event context -danb
		#
		##so for example, the if statement below will check if the object meta contains the "emotion" metadata.
		##you could point the raycasting controller at something else, and it will not register, because of course
		## it does not contain the "emotion" metadata, hence why this can be universally used.
		## -danb
	#
		#if hit and hit.has_meta("emotion"):
			#var selected_emotion = hit.get_meta("emotion")
			#check_answer(selected_emotion)
		
		

func btnPressedLeft(name_action:String) -> void:
	if name_action == "trigger_click":
		
		if targetObject and targetObject.has_meta("emotion"):
			var selected_emotion = targetObject.get_meta("emotion")
			if check_answer(selected_emotion):
				next_question()
		if targetObject and targetObject.name == "Proceed":
			if get_tree().get_current_scene().name != "Tutorial_1":
				get_tree().change_scene_to_file("res://menu.tscn")
			else:
				get_tree().change_scene_to_file("res://tutorial_scene_2.tscn")
		if targetObject and targetObject.name == "Restart":
			get_tree().change_scene_to_file("res://tutorial_scene_2.tscn")
		if targetObject and targetObject.name == "Next":
			play_sound("Wrong")
			select_next.next();
		
