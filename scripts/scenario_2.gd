extends Node3D

@onready var raycast := $XROrigin3D/RightHandController/RayCast3D
@onready var label := $Label3D
@onready var mesh : MeshInstance3D = null;

# Timer variables
var cooldown_time := 0.5 # seconds
var cooldown_timer := 0.0

func _physics_process(delta):
	if cooldown_timer > 0:
		cooldown_timer -= delta
	if raycast.is_colliding():
		var collider_object = raycast.get_collider()
		#print(collider.name)
		if collider_object is CollisionObject3D:
			mesh = collider_object.get_node("MeshInstance3D")
			mesh.get_active_material(0).metallic = 1.5
	else:
		if mesh != null:
			mesh.get_active_material(0).metallic = 0
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if ($XROrigin3D/RightHandController.is_button_pressed("trigger") or $XROrigin3D/RightHandController.is_button_pressed("select_button")) and cooldown_timer <= 0:
			if collider.name == "Happy":
				label.text = tr("Correct she is feeling happy because she got a gift") 
				undisplay_emotions()
			if collider.name == "Sad":
				label.text = tr("She does not seem sad")
			if collider.name == "Fear":
				label.text = tr("She does not seem afraid")
			if collider.name == "Anger":
				label.text = tr("She does not seem angry")
			if collider.name == "Continue":
				get_tree().change_scene_to_file("res://scenes/transition.tscn")
			start_cooldown()

func start_cooldown():
	cooldown_timer = cooldown_time
	
func undisplay_emotions():
	$Continue.visible = true
	$Continue/CollisionShape3D.disabled = false
	$Node3D.visible = false
	#collisions
	$Node3D/Anger/CollisionShape3D.disabled = true
	$Node3D/Happy/CollisionShape3D.disabled = true
	$Node3D/Sad/CollisionShape3D.disabled = true
	$Node3D/Fear/CollisionShape3D.disabled = true
