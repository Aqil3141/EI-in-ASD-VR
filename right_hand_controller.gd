extends XRController3D

func _physics_process(delta: float) -> void:
	if $RayCast3D.is_colliding():
		print("is colliding")
