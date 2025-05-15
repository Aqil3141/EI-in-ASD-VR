extends Control

var color;
func _color_pick(new_color: Color):
	color = new_color

func set_color():
	Globals.set_hand_color(color)
	refresh_hand_model()

func _on_back_to_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")

func refresh_hand_model():
	var hand_path = preload("res://hand_custom.tscn")
	var viewport = $SubViewportContainer/SubViewport

	var old_hand = viewport.get_child(0)
	if old_hand:
		old_hand.queue_free()

	var new_hand = hand_path.instantiate()
	new_hand.name = "Hands"
	viewport.add_child(new_hand)
