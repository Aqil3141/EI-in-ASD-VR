extends Node3D

var emotions = [
	preload("res://audio/anger.mp3"),
	preload("res://audio/fear.mp3"),
	preload("res://audio/happiness.mp3"),
	preload("res://audio/sad.mp3")
]

func play_sad():
	var player = $Emotion
	player.stream = emotions[count % emotions.size()]
	player.play()
