extends Node3D

func _ready():
	get_parent().connect("result_checked", Callable(self, "_on_result_checked"))
	print("Signal connected!")

func _on_result_checked(is_correct: bool):
	if is_correct:
		self.text = "Good job!"
	else:
		self.text = "Wrong!"
