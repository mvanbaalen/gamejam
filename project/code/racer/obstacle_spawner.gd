extends Node

const OBSTACLES = [
	preload("res://scenes/racer/rock.tscn")
]

export var default_spawn_distance = 500.0
export var default_spawn_variation = 0.2
export var default_spawn_increase = 0.1

onready var game_state = get_tree().get_nodes_in_group("racer_state")[0]

var spawn_ready

func _ready():
	randomize()
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
	var new_rock = OBSTACLES[0].instance()
	new_rock.position.x = 500
	new_rock.position.y = -1 * new_rock.get_node("Collision").shape.extents.y
	add_child(new_rock)