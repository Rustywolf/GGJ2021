extends Spatial


export var delay := 0.0
export var cooldown := 1.0

onready var Car := preload("res://Scenes/Characters/Car/Car.tscn")

var time := 0.0

func _ready():
	time = delay
	

func _process(delta):
	time -= delta
	if time < 0:
		time += cooldown
		
		var car = Car.instance()
		add_child(car)
