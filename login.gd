extends Control

var email = ""
var password

var created = false

func _on_login_button_down() -> void:
	if !created:
		email = $Email.text
		password = $Password.text.sha256_text()
		created = true
		$Email.text = ""
		$Password.text = ""
		print("Account Created")
	else:
		if $Email.text == 	email:
			if $Password.text.sha256_text() == password:
				print("Login Success")
				get_tree().change_scene_to_file("res://main.tscn")
			else:
				print("Login Fail")	
