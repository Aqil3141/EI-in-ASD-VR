extends Control

func _on_login_page_button_down() -> void:
	get_tree().change_scene_to_file("res://login.tscn")
	

func _on_options_page_button_down() -> void:
	get_tree().change_scene_to_file("res://options.tscn")
