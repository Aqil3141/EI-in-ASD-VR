extends Control

func _on_language_button_down() -> void:
	get_tree().change_scene_to_file("res://language.tscn")

func _on_back_to_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
