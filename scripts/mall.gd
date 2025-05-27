extends Node3D

@onready var raycast := $XROrigin3D/RightHandController/RayCast3D
@onready var label := $Label3D

var system_sequence = [tr("There's a young girl named Mariam standing nearby"), tr("Mariam appears to be lost Observe her closely"), tr("How do you think Mariam is feeling?"), "display", "continue", "move"]
var girl_sequence = [tr("Mom? Dad? Where are you?"), tr("I... I can't find them...")] 
var count = 0

# Timer variables
var cooldown_time := 0.5 # seconds
var cooldown_timer := 0.0
var movement = false;
var emotion = false;

func _physics_process(delta):
	if cooldown_timer > 0:
		cooldown_timer -= delta
	if movement:
		$girl.position = $girl.position.move_toward(Vector3(-500, 0, 500), 2 * delta)
	if raycast.is_colliding():
		
		var collider = raycast.get_collider()
		if collider.name == "Continue" and $XROrigin3D/RightHandController.is_button_pressed("trigger") and cooldown_timer <= 0 and !emotion:
			if system_sequence[count%len(system_sequence)] == "continue":
				label.text = tr("Press 'Continue' to move onto a different level")
				$Continue/Label3D.text = tr("Continue")
				$Continue/Label3D.font_size = 17
			elif system_sequence[count%len(system_sequence)] == "move":
				get_tree().change_scene_to_file("res://transition.tscn")
			elif system_sequence[count%len(system_sequence)] != "display":
				label.text = tr(system_sequence[count]) 
			else:
				display_emotions()
			if $Continue/Label3D.text == tr("Continue"):
				$girl_text.text = tr("Mom! Dad! I'm here!")
				#mat.albedo_color.a = max(mat.albedo_color.a - FADE_SPEED * delta, 0)
				$girl/AnimationPlayer.play("Armature_001|mixamo_com|Layer0")
				$girl/AnimationPlayer.get_animation("Armature_001|mixamo_com|Layer0").loop = true
				movement = true
			elif randi_range(0, 3) == 1:
				$girl_text.text = tr(girl_sequence[count%len(girl_sequence)])
			count += 1
			start_cooldown()
		if emotion:
			if $XROrigin3D/RightHandController.is_button_pressed("trigger") and cooldown_timer <= 0:
				if collider.name == "Happy":
					label.text = tr("Mariam does not seem happy She is not smiling") 
				if collider.name == "Sad":
					label.text = tr("Mariam may seem sad but do you think she is feeling something else?")
				if collider.name == "Fear":
					label.text = tr("Correct Mariam is feeling fear Her hands are close to her body")
					undisplay_emotions()
				if collider.name == "Anger":
					label.text = tr("Mariam does not seem angry Her eyebrows do not curl downwards")
				start_cooldown()

func start_cooldown():
	cooldown_timer = cooldown_time

func display_emotions():
	$Continue.visible = false
	emotion = true
	$Node3D.visible = true

func undisplay_emotions():
	$Continue.visible = true
	emotion = false
	$Node3D.visible = false
