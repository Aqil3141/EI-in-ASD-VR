extends Area3D
var count = 0;
var emotions = ["Anger", "Fear", "Happy", "Sad"] #emotion nodes alongside this node
var emotion;

func _ready() -> void:
	await get_tree().create_timer(3.0).timeout
	self.visible = true

func next():
	make_invisible(emotions[count%4])
	count = count + 1;
	make_visible(emotions[count%4])
	if count >= 4:
		get_parent().get_node("Proceed").make_visible()
	
func make_visible(current_emotion):
	emotion = get_parent().get_node(current_emotion)
	emotion.visible = true
	

func make_invisible(current_emotion):
	emotion = get_parent().get_node(current_emotion)
	emotion.visible = false
