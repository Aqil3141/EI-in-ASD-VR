extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
var username = ""

# Saving data to database with inserted name
func _on_save_name_button_down() -> void:
	username = $VBoxContainer/Username.text
	if username != "":
		# Save data from all tutorial scenes to name as row in database
		Globals.username = username
		get_tree().change_scene_to_file("res://menu.tscn")
	else:
		$VBoxContainer/Label.text = "Enter name"
		
	
# Saving data anonymously
func _on_save_anon_button_down() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
	
# Back to menu
func _on_back_button_down() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
