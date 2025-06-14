extends Node

var player: AudioStreamPlayer

func _ready():
	# Create and configure the AudioStreamPlayer
	player = AudioStreamPlayer.new()
	add_child(player)

	# Load the music and enable looping on the stream
	var stream = preload("res://assets/audio/music.mp3")  # Replace with your actual path
	stream.loop = true
	player.volume_db = linear_to_db(0.1)
	# Assign the stream and start playback
	player.stream = stream
	#Separate audio bus so that main audio bus can play sound effects and audio prompts
	player.bus = "Music" 
	player.play()
