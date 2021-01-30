extends RigidBody

const SPEED := 1.0

onready var nav: Navigation = $"../Navigation"
onready var player: Spatial = $"../Player"

export var first_name := ""

var target = null

var collisions = []
var flying := false

var path = []
var path_idx = 0
var path_calc_time = 1.0
var path_calc_remaining = 0.0
var path_force_update = false


func _ready():
	target = player.get_node("Tracking/" + first_name)
	

func _process(delta):
	$Body.look_at(player.global_transform.origin, Vector3.UP)
	
	path_calc_remaining -= delta
	if path_calc_remaining < 0:
		path_calc_remaining += path_calc_time
		path = nav.get_simple_path(global_transform.origin, target.global_transform.origin)
		path_idx = 0
		path_force_update = true
		

func add_collision(impact):
	collisions.push_back(impact)
	

func _physics_process(delta):
	if collisions.size() > 0:
		
		for collision in collisions:
			apply_torque_impulse(transform.basis.x)
			for impact in collision:
				apply_central_impulse(impact)
			
		collisions = []
		flying = true
		

func _set_velocity(state, target):
	var closest = nav.get_closest_point(global_transform.origin)
	state.linear_velocity = (target - closest).normalized() * SPEED
	

func _integrate_forces(state):
	if not path or path.size() <= path_idx or flying:
		return
		
	if path_force_update:
		_set_velocity(state, path[path_idx])
		path_force_update = false
		
	if path[path_idx].distance_squared_to(nav.get_closest_point(global_transform.origin)) < 1:
		path_idx += 1
		if path.size() > path_idx:
			_set_velocity(state, path[path_idx])
			
	if (global_transform.origin.distance_squared_to(player.global_transform.origin)) < 1:
		state.linear_velocity = Vector3.ZERO
		

func _on_Ground_entered(body):
	if body.get_parent().is_in_group("Pavement"):
		$Body.translation.y = 0.4
	

func _on_Ground_exited(body):
	if body.get_parent().is_in_group("Pavement"):
		$Body.translation.y = 0


func _on_Kid_body_entered(body):
	if body.is_in_group("Ground"):
		flying = false
