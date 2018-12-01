extends Node

const OBSTACLES = [
	preload("res://scenes/racer/rock.tscn"),
	preload("res://scenes/racer/enemy_car.tscn"),
	preload("res://scenes/racer/booster.tscn")
]

export var default_spawn_distance = 500.0
export var default_spawn_variation = 0.2
export var default_spawn_increase = 0.1

onready var game_state = get_tree().get_nodes_in_group("racer_state")[0]

var spawn_ready

func _ready():
	reset_spawn_time()

func _process(delta):
	spawn_ready -= delta * game_state.car_speed()
	if spawn_ready <= 0:
		spawn_random_object()
		reset_spawn_time()
	
func reset_spawn_time():
	var spawn_variation = default_spawn_distance * default_spawn_variation
	spawn_ready = default_spawn_distance + rand_range(-spawn_variation, spawn_variation)

func spawn_random_object():
	var new_obstacle = OBSTACLES[randi() % OBSTACLES.size()].instance()
	var extents = new_obstacle.get_node("Collision").shape.extents
	var bounds = game_state.visible_bounds()
	new_obstacle.position.x = rand_range(bounds[0] + extents.x, bounds[1] - extents.x)
	new_obstacle.position.y = -1 * extents.y
	add_child(new_obstacle)