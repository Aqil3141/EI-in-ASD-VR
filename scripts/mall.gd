extends Node3D

#Node references set on scene load. 'onready' 
#as the scene needs to load in first before referencing 
@onready var raycast := $XROrigin3D/RightHandController/RayCast3D
@onready var label := $Label3D
@onready var player := $AudioStreamPlayer

#dialog interaction sequences for simplicity
#includes keys to help with internal tracking
var system_sequence = [tr("There's a young girl named Mariam standing nearby"), tr("Mariam appears to be lost Observe her closely"), tr("How do you think Mariam is feeling?"), "display", "continue", "move"]
var girl_sequence = [tr("Mom? Dad? Where are you?"), tr("I can't find them")] 
var count = 0

# Timer variables to prevent rapid interactions and bugs
var cooldown_time := 0.5 # seconds
var cooldown_timer := 0.0
#flags
var movement = false;
var emotion = false;
var audio_stream;
var mesh : MeshInstance3D = null;

# Called every physics frame; handles raycasting, highlighting, and movement
func _physics_process(delta):
	# Highlight object if raycast hits a CollisionObject3D
	if raycast.is_colliding():
		var collider_object = raycast.get_collider()
		#print(collider.name)
		if collider_object is CollisionObject3D:
			mesh = collider_object.get_node("MeshInstance3D")
			mesh.get_active_material(0).metallic = 1.5
	else:
		if mesh != null:
			mesh.get_active_material(0).metallic = 0
	# Countdown timer for cooldown-based input
	if cooldown_timer > 0:
		cooldown_timer -= delta
	# Move the girl when triggered (it looks like she found her parents in the game)
	if movement:
		$girl.position = $girl.position.move_toward(Vector3(-500, 0, 500), 2 * delta)
	
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		# When "Continue" is selected and not in emotion selection state
		if collider.name == "Continue" and ($XROrigin3D/RightHandController.is_button_pressed("trigger") or $XROrigin3D/RightHandController.is_button_pressed("select_button")) and cooldown_timer <= 0 and !emotion:
			#proceed with regular dialogue
			if system_sequence[count%len(system_sequence)] == "continue":
				label.text = tr("Press 'Continue' to move onto a different level")
				audio_stream = load("res://assets/audio/System_mall_3.mp3")
				player.stream = audio_stream
				player.play()
				$Continue/Label3D.text = tr("Continue")
				$Continue/Label3D.font_size = 17
			elif system_sequence[count%len(system_sequence)] == "move":
				get_tree().change_scene_to_file("res://scenes/transition.tscn")
			elif system_sequence[count%len(system_sequence)] != "display":
				label.text = tr(system_sequence[count]) 
				audio_stream = load("res://assets/audio/System_mall_"+str(count)+".mp3")
				player.stream = audio_stream
				player.play()
			else:
				#trigger emotion state once first part of the dialogue is over
				display_emotions()
			if $Continue/Label3D.text == tr("Continue"):
				$girl_text.text = tr("Mom! Dad! I'm here!")
				#mat.albedo_color.a = max(mat.albedo_color.a - FADE_SPEED * delta, 0)
				$girl/AnimationPlayer.play("Armature_001|mixamo_com|Layer0")
				$girl/AnimationPlayer.get_animation("Armature_001|mixamo_com|Layer0").loop = true
				movement = true
			else:
				$girl_text.text = tr(girl_sequence[count%len(girl_sequence)])
			count += 1
			start_cooldown()
		# Handle emotion button interaction
		if emotion:
			if ($XROrigin3D/RightHandController.is_button_pressed("trigger") or $XROrigin3D/RightHandController.is_button_pressed("select_button")) and cooldown_timer <= 0:
				if collider.name == "Happy":
					label.text = tr("Mariam does not seem happy She is not smiling") 
					audio_stream = load("res://assets/audio/Happy_mall.mp3")
				if collider.name == "Sad":
					label.text = tr("Mariam may seem sad but do you think she is feeling something else?")
					audio_stream = load("res://assets/audio/Sad_mall.mp3")
				if collider.name == "Fear":
					label.text = tr("Correct Mariam is feeling fear Her hands are close to her body")
					audio_stream = load("res://assets/audio/Fear_mall.mp3")
					undisplay_emotions()
				if collider.name == "Anger":
					label.text = tr("Mariam does not seem angry Her eyebrows do not curl downwards")
					audio_stream = load("res://assets/audio/Angry_mall.mp3")
				player.stream = audio_stream
				player.play()
				start_cooldown()

# Resets the cooldown timer
func start_cooldown():
	cooldown_timer = cooldown_time

# Displays emotion options (Happy, Sad, Fear, Anger) for user interaction
func display_emotions():
	$Continue.visible = false
	$Continue/CollisionShape3D.disabled = true
	emotion = true
	$Node3D.visible = true
	#collisions
	$Node3D/Anger/CollisionShape3D.disabled = false
	$Node3D/Happy/CollisionShape3D.disabled = false
	$Node3D/Sad/CollisionShape3D.disabled = false
	$Node3D/Fear/CollisionShape3D.disabled = false

# Hides emotion options (Happy, Sad, Fear, Anger) from user interaction
func undisplay_emotions():
	$Continue.visible = true
	$Continue/CollisionShape3D.disabled = false
	emotion = false
	$Node3D.visible = false
	#collisions
	$Node3D/Anger/CollisionShape3D.disabled = true
	$Node3D/Happy/CollisionShape3D.disabled = true
	$Node3D/Sad/CollisionShape3D.disabled = true
	$Node3D/Fear/CollisionShape3D.disabled = true
