extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Globals.username != "":
		if is_instance_valid($Label_Menu):
			$Label_Menu.text = tr("Welcome ") + Globals.username + "\n" + tr("ASD VR Assessment");
		
func _on_login_page_button_down() -> void:
	get_tree().change_scene_to_file("res://login.tscn")
	
func _on_options_page_button_down() -> void:
	get_tree().change_scene_to_file("res://options.tscn")

func _on_play_button_down() -> void:
	get_tree().change_scene_to_file("res://Play.tscn")

func _on_tutorial_1_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial_scene_1.1.tscn")

func _on_tutorial_2_button_down() -> void:
	get_tree().change_scene_to_file("res://tutorial_scene_1.tscn")

func _on_back_button_down() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
