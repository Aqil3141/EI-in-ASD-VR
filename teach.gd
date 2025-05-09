extends Node

signal animation_done(animation_name: String)


func _ready():
	$AnimationPlayer.connect("animation_finished", Callable(self, "_on_animation_finished"))

# Call this externally to trigger animation and pose
func play_and_pose(animation_name: String):
	var anim_player = $AnimationPlayer
	if anim_player.has_animation(animation_name):
		anim_player.play(animation_name)
	else:
		print("Animation not found: ", animation_name)

func _on_animation_finished(name: String):
	# Seek to hold time and stop (freeze at pose)
	var anim_player = $AnimationPlayer
	anim_player.play("Armature_001|mixamo_com|Layer0")
	anim_player.seek(1, true)
	anim_player.stop()

	# Optional: emit signal to let other nodes react
	emit_signal("animation_done", name)
