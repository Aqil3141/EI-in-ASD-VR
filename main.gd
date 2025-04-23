extends Node3D
func _ready():
	#when the scene loads, assign a reference to the CurrentQuestion label so that it updates with text
	$XROrigin3D/RightHandController.set_label_node($Options/CurrentQuestion)
	
	#set righthandcontroller after the tree loads so that it doesnt attempt
	#to call a null instance (which would be RightHandController) as it would otherwise call it before it loads.
	#-danb
	#var options = $Options
	#var controller = $XROrigin3D/RightHandController
	#options.set_controller(controller)
