extends Node

const small_star = preload("res://graphics/shooter/star1.png")
const medium_star = preload("res://graphics/shooter/star2.png")
const large_star = preload("res://graphics/shooter/star3.png")
const star_scene = preload("res://scenes/shooter/star.tscn")

var wait_time = 0

func _ready():
	randomize()
	wait_time = rand_range(0.1, 0.3)

func _process(delta):
	wait_time -= delta
	if wait_time <= 0:
		spawn_star()
		randomize()
		wait_time = rand_range(0.1, 0.3)
	pass
	
func spawn_star():
	randomize()
	var screen_min = 0
	var screen_max = get_viewport().get_visible_rect().size.x
	var star_instance = star_scene.instance()
	star_instance.position = Vector2(rand_range(screen_min, screen_max), -16)
	add_child(star_instance)
	
