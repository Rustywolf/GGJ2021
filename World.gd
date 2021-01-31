extends Control

var hovering_exit := false


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if $Overlay.visible:
			$Overlay.visible = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_tree().paused = false
		else:
			$Overlay.visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().paused = true


func _on_Exit_mouse_entered():
	hovering_exit = true
	$Overlay/Exit.set("custom_colors/default_color", "#AAAAAA")


func _on_Exit_mouse_exited():
	hovering_exit = true
	$Overlay/Exit.set("custom_colors/default_color", "#FFFFFF")


func _on_Exit_gui_input(event):
	if event.is_action_pressed("LeftClick"):
		if hovering_exit:
			get_tree().quit()


func set_distracted(child):
	get_node("UI/%s/I_Eloise_DIS" % child).visible = true
	get_node("UI/%s/I_Eloise_HOL" % child).visible = false
	get_node("UI/%s/I_Eloise_REG" % child).visible = false
	pass


func set_hole(child):
	get_node("UI/%s/I_Eloise_DIS" % child).visible = false
	get_node("UI/%s/I_Eloise_HOL" % child).visible = true
	get_node("UI/%s/I_Eloise_REG" % child).visible = false
	pass


func set_normal(child):
	get_node("UI/%s/I_Eloise_DIS" % child).visible = false
	get_node("UI/%s/I_Eloise_HOL" % child).visible = false
	get_node("UI/%s/I_Eloise_REG" % child).visible = true
	pass
