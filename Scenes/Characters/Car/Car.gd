extends Spatial

var speed := 10.0
const IMPACT := 5.0

func _physics_process(delta):
	translation += transform.basis.z * delta * speed
	

func _on_Car_body_entered(body):
	if body.is_in_group("kid"):
		var direction = (transform.origin - body.transform.origin).normalized()
		body.add_collision([direction * IMPACT, transform.basis.y * IMPACT])
