extends Area


func _on_Spatial_area_entered(area):
	if area.is_in_group("Attention"):
		area.get_parent()._on_Distraction_entered(get_parent())
		
