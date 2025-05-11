extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	print(Globals.username)
	if Globals.username != "":
		$Label.text = "Welcome " + Globals.username + " to the \nASD VR Assessment";
		
func _on_login_page_button_down() -> void:
	get_tree().change_scene_to_file("res://login.tscn")
	
func _on_options_page_button_down() -> void:
	get_tree().change_scene_to_file("res://options.tscn")

func _on_play_button_down() -> void:
	get_tree().change_scene_to_file("res://Play.tscn")

func _on_tutorial_1_button_down() -> void:
	get_tree().change_scene_to_file("res://tutorial_scene_1.tscn")

func _on_tutorial_2_button_down() -> void:
	get_tree().change_scene_to_file("res://tutorial_scene_2.tscn")

func _on_back_button_down() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
