extends StaticBody3D

func make_visible():
	self.visible = true
	# Disable
	$CollisionShape3D.disabled = false

func on_interact():
	print("You've interacted with me!")
	
