extends Node3D
signal result_checked(is_correct: bool)
func _ready():
	#when the scene loads, assign a reference to the CurrentQuestion label so that it updates with text
	$XROrigin3D/RightHandController.set_label_node($Options/CurrentQuestion)
	
	#set righthandcontroller after the tree loads so that it doesnt attempt
	#to call a null instance (which would be RightHandController) as it would otherwise call it before it loads.
	#-danb
	#var options = $Options
	#var controller = $XROrigin3D/RightHandController
	#options.set_controller(controller)

#XROrigin3D/player_button.tscn has to be a child node of the selection.tscn node
#Main |
#     -> XROrigin3D (player_button.tscn) 
func send_signal(bool):
	emit_signal("result_checked", bool)
