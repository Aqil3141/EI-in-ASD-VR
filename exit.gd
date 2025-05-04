extends Area3D

func make_visible():
	$MeshInstance3D.visible = true
	$CollisionShape3D.disabled = false
	$CollisionShape3D.visible = true
	$Label3D.visible = true
