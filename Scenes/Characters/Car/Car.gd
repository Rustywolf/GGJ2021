extends Spatial

var speed := 10.0
const IMPACT := 10.0
var traveled := 0.0

func _physics_process(delta):
	var move = global_transform.basis.z * delta * speed
	global_transform.origin += move
	traveled += move.length()
	if traveled > 120.0:
		get_parent().remove_child(self)
		queue_free()
	

func _on_Car_body_entered(body):
	if body.is_in_group("kid"):
		var direction = (transform.origin - body.transform.origin).normalized()
		body.add_collision([direction * IMPACT, transform.basis.y * IMPACT])
