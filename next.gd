extends Area3D
var count = 0;
var emotions = ["Anger", "Fear", "Happy", "Sad"] #emotion nodes alongside this node
var emotion;

func _ready() -> void:
	play_model_animation("Armature_004|mixamo_com|Layer0_001")
	await get_tree().create_timer(1.0).timeout
	get_node("/root/Tutorial_1/AudioStreamPlayer").play()
	await get_tree().create_timer(2.0).timeout
	self.visible = true
	
func next():
	make_invisible(emotions[count%4])
	count = count + 1;
	make_visible(emotions[count%4])
	play_sound()
	if count >= 4:
		get_parent().get_node("Proceed").make_visible()
	
func make_visible(current_emotion):
	emotion = get_parent().get_node(current_emotion)
	emotion.visible = true
	

func make_invisible(current_emotion):
	emotion = get_parent().get_node(current_emotion)
	emotion.visible = false

func play_model_animation(animation):
	var model = get_node("/root/Tutorial_1/teacher")  # Adjust path as needed
	var anim_player = model.get_node("AnimationPlayer")  # Or path to AnimationTree
	#print(anim_player.get_animation_list()) #Check for all animation names
	model.play_and_pose(animation)

var emotion_sounds = [
	preload("res://assets/audio/anger.mp3"),
	preload("res://assets/audio/fear.mp3"),
	preload("res://assets/audio/happiness.mp3"),
	preload("res://assets/audio/sad.mp3")
]

func play_sound():
	var player = get_parent().get_node("Emotion")
	player.volume_db = Globals.sound_volume
	player.stream = emotion_sounds[count % 4]
	player.play()

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
			
