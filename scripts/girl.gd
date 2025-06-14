extends Node3D

# Create signal to emit when an animation finishes
# The code was copied from teach.gd but I did not have time to review
#this signal may not be needed (as the character model stays on loop and doesnt need an
#ending position)
# Due to time constraints I will be leaving it here
signal animation_done(animation_name: String)

#Start a scared animation and keep it on repeat
func _ready():
	$AnimationPlayer.connect("animation_finished", Callable(self, "_on_animation_finished"))
	# Play the default looping scared animation when the scene starts
	$AnimationPlayer.play("Armature|mixamo_com|Layer0")
	$AnimationPlayer.get_animation("Armature|mixamo_com|Layer0").loop = true

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
	anim_player.play("Armature|mixamo_com|Layer0")
	anim_player.seek(3, true)
	anim_player.stop()
	emit_signal("animation_done", name)
