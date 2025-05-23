extends Control


func _ready():
	if(self.name == "Music"): #For music screen
		$Panel/music_slider.value = Globals.music_volume
		$Panel/sound_slider.value = Globals.sound_volume
	
func _on_language_button_down() -> void:
	get_tree().change_scene_to_file("res://language.tscn")

func _on_back_to_music_button_down() -> void:
	get_tree().change_scene_to_file("res://music.tscn")

func _on_back_to_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
	
func _on_back_to_customize_button_down() -> void:
	get_tree().change_scene_to_file("res://customize.tscn")
	
func music_volume_change(music: float) -> void:
	Globals.music_volume = music;
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(Globals.music_volume))
	
func sound_volume_change(sound: float) -> void:
	Globals.sound_volume = sound;

func change_language_to_english() -> void:
	TranslationServer.set_locale("en")
	get_tree().reload_current_scene()

func change_language_to_arabic() -> void:
	TranslationServer.set_locale("ar")
	get_tree().reload_current_scene()
	
