extends CSGBox


func _on_Area_body_entered(body):
	if body.has_method("_on_Ground_entered"):
		body._on_Ground_entered(self)


func _on_Area_body_exited(body):
	if body.has_method("_on_Ground_exited"):
		body._on_Ground_exited(self)
