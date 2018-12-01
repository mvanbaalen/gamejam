extends Node2D

const SPEED_MODIFIER = 10

var score = 0
var distance_traveled = 0
var boosts_hit = 0

# This is ideally the ONLY script that knows about arbitrary nodes.
# I'm doing this so that other knows can ask this node where things are.
onready var car_object = $Car
onready var camera_object = $Cam

func _ready():
	pass
	
func car_speed():
	return car_object.vert_speed
	
func get_score():
	return floor(distance_traveled/100) + score
	
func _process(delta):
	distance_traveled += car_speed()*delta
	results.racer_data["Distance"] = int(distance_traveled)
	
func obstacle_avoided():
	add_score(2)
	
func add_score(value):
	score += value
	results.racer_data["Score"] = get_score()
	
func visible_bounds():
	var view_x_min = camera_object.position.x - (get_viewport().size.x / 2)
	var view_x_max = (get_viewport().size.x / 2) + camera_object.position.x
	return [view_x_min, view_x_max]
	#TODO Return a rect if we want
	
func update_results():
	pass
