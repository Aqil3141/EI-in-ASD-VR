extends XRController3D

var targetObject = null

func _ready() -> void:
	connect("button_pressed", btnPressedLeft)

func _physics_process(delta: float) -> void:
	if $RayCast3D.is_colliding():
		var c = $RayCast3D.get_collider()
		targetObject = c
		#prints name of raycasted object
		if targetObject:
			print(targetObject.name)
	else:
		targetObject = null
		

func btnPressedLeft(name:String) -> void:
	print(name)
	if name == "trigger_click":
		if targetObject:
			targetObject.queue_free()
