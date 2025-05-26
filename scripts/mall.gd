extends Node3D

@onready var raycast := $XROrigin3D/RightHandController/RayCast3D
@onready var label := $Label3D

var system_sequence = ["There's a young girl named Mariam\nstanding nearby", "Mariam appears to be lost\nObserve her closely", "How do you think\nMariam is feeling?", "display", "continue", "move"]
var girl_sequence = ["Mom? Dad? Where are you?", "I... I can't find them..."]
var count = 0

# Timer variables
var cooldown_time := 1.0 # seconds
var cooldown_timer := 0.0

var emotion = false;
func _physics_process(delta):
	if cooldown_timer > 0:
		cooldown_timer -= delta

	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.name == "Continue" and $XROrigin3D/RightHandController.is_button_pressed("trigger") and cooldown_timer <= 0 and !emotion:
			if system_sequence[count%len(system_sequence)] == "continue":
				label.text = "Press 'Continue' to move onto a different level"
				$Continue/Label3D.text = "Continue"
				$Continue/Label3D.font_size = 17
			elif system_sequence[count%len(system_sequence)] == "move":
				get_tree().change_scene_to_file("res://transition.tscn")
			elif system_sequence[count%len(system_sequence)] != "display":
				label.text = system_sequence[count%len(system_sequence)] 
			else:
				display_emotions()
			if randi_range(0, 3) == 1:
				$girl/Label3D.text = girl_sequence[count%len(girl_sequence)]
			count += 1
			start_cooldown()
		if emotion:
			if $XROrigin3D/RightHandController.is_button_pressed("trigger") and cooldown_timer <= 0:
				if collider.name == "Happy":
					label.text = "Mariam does not seem happy\nShe is not smiling" 
				if collider.name == "Sad":
					label.text = "Mariam may seem sad\nbut do you think she is feeling something else?"
				if collider.name == "Fear":
					label.text = "Correct Mariam is feeling fear\nHer hands are close to her body"
					undisplay_emotions()
				if collider.name == "Anger":
					label.text = "Mariam does not seem angry\nHer eyebrows do not curl downwards"
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
