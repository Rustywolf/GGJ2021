extends Spatial


func _ready():
	var ground = get_parent().get_node("Ground")
	for child in get_children():
		var global_transform = child.global_transform
		remove_child(child)
		ground.add_child(child)
		child.global_transform = global_transform
