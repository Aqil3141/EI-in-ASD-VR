extends Node3D

func _ready():
	get_parent().connect("result_checked", Callable(self, "_on_result_checked"))
	print("Signal connected!")

func _on_result_checked(count: String):
	if int(count) < 4:
		self.text = "Good job! " + count + "/4"
	if int(count) >= 4:
		self.font_size = 16
		self.text = "Wonderful! You have finished the tutorial"
		self.text += "\nClick on the 'Proceed' button to move to the next stage"
		get_parent().get_node("Proceed").make_visible()
