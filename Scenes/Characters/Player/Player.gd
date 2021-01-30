extends KinematicBody

const CAM_SPEED := 0.25
const MOVE_SPEED := 2.5
const PUSH_STRENGTH := 0.5
const MAX_Y_VELOCITY := -20.0

onready var camera := $Camera

var move_forward := false
var move_backward := false
var move_left := false
var move_right := false
var velocity_y = 0.0


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _physics_process(delta):
	var velocity := Vector3(0, velocity_y, 0)
	
	velocity_y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta
	if velocity_y < MAX_Y_VELOCITY:
		velocity_y = MAX_Y_VELOCITY
	
	if move_forward:
		velocity += -transform.basis.z * MOVE_SPEED
		
	if move_backward:
		velocity += transform.basis.z * MOVE_SPEED
		
	if move_left:
		velocity += -transform.basis.x * MOVE_SPEED
		
	if move_right:
		velocity +=transform.basis.x * MOVE_SPEED
	
	move_and_slide(velocity, Vector3.UP, false, 4, 0.785398, false)
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("bodies"):
			collision.collider.apply_central_impulse(-collision.normal * PUSH_STRENGTH)
			
	if is_on_floor():
		velocity_y = 0
		

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit(0)
		
	if event is InputEventMouseMotion:
		var relative: Vector2 = event.relative
		var rot_x = camera.rotation_degrees.x - relative.y * CAM_SPEED
		var rot_y = rotation_degrees.y - relative.x * CAM_SPEED
		camera.rotation_degrees.x = min(max(rot_x, -80), 80)
		rotation_degrees.y = rot_y
	
	if event.is_action_pressed("move_forward"):
		move_forward = true
	elif event.is_action_released("move_forward"):
		move_forward = false
	
	if event.is_action_pressed("move_backward"):
		move_backward = true
	elif event.is_action_released("move_backward"):
		move_backward = false
	
	if event.is_action_pressed("move_left"):
		move_left = true
	elif event.is_action_released("move_left"):
		move_left = false
	
	if event.is_action_pressed("move_right"):
		move_right = true
	elif event.is_action_released("move_right"):
		move_right = false
	
	if event.is_action_pressed("use_lollipop"):
		$AnimationPlayer.play("Lollipop")
		

func _on_Ground_entered(body):
	if body.get_parent().is_in_group("Pavement"):
		camera.transform.origin.y = 2.0
	

func _on_Ground_exited(body):
	if body.get_parent().is_in_group("Pavement"):
		camera.transform.origin.y = 1.6
	
