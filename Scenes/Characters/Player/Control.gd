extends Control

onready var player = get_parent()

func _input(event):
	if (event.is_action_pressed("LeftClick")):
		if player.hover_exit:
			get_tree().quit()
		if player.hover_retry:
			get_tree().change_scene("res://World.tscn")
			get_tree().paused = false
