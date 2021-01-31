extends Spatial


export var delay := 0.0
export var cooldown := 1.0
export var speed := 10.0

onready var Car := preload("res://Scenes/Characters/Car/Car.tscn")

var time := 0.0


func _ready():
	time = delay
	

func _process(delta):
	time -= delta
	if time < 0:
		time += cooldown
		
		var car = Car.instance()
		car.speed = speed
		car.global_transform = global_transform
		$"../../Cars".add_child(car)
