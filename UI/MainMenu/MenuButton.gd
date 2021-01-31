extends RichTextLabel

var hovering := false

func _on_StartButton_mouse_entered():
	set("custom_colors/default_color", "#AAAAAA")
	hovering = true
	

func _on_StartButton_mouse_exited():
	set("custom_colors/default_color", "#FFFFFF")
	hovering = false
	

func _handle_click():
	if name == "StartButton":
		get_tree().change_scene("res://World.tscn")
	elif name == "ExitButton":
		get_tree().quit()
	

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if hovering:
				_handle_click()
				accept_event()
