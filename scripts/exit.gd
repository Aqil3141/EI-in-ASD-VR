extends Area3D

#Turns the current object visible for players to see (made during early development and  can be optimized)
func make_visible():
	$MeshInstance3D.visible = true
	$CollisionShape3D.disabled = false
	$CollisionShape3D.visible = true
	$Label3D.visible = true
	get_parent().get_node("Options").visible = false
