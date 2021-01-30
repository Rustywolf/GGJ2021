extends Spatial


func _on_Area_body_entered(body):
	if body.is_in_group("Car"):
		body.get_parent().remove_child(body)
		body.queue_free()
