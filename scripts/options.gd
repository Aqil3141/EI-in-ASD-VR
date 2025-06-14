extends Control

#Sets the sound and music sliders to a set volume
func _ready():
	if(self.name == "Music"): #For music screen
		$Panel/music_slider.value = Globals.music_volume
		$Panel/sound_slider.value = Globals.sound_volume

#Functions meant for button clicks.
#When a button is clicked, it will select its appropriate function
func _on_language_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/language.tscn")

func _on_back_to_music_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/music.tscn")

func _on_back_to_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
func _on_back_to_customize_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/customize.tscn")
	
#Music and volume functions
func music_volume_change(music: float) -> void:
	Globals.music_volume = music;
	#Use a different sound bus for music as the main bus has sound effects and voices
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(Globals.music_volume))
	
func sound_volume_change(sound: float) -> void:
	Globals.sound_volume = sound;

#Language toggle functions (godot does most of the heavy lifting)
#You can check the csv file for the language words
func change_language_to_english() -> void:
	TranslationServer.set_locale("en")
	get_tree().reload_current_scene()

func change_language_to_arabic() -> void:
	TranslationServer.set_locale("ar")
	get_tree().reload_current_scene()
	
