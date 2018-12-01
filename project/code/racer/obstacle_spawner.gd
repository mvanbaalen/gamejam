extends Node

const OBSTACLE_DATA = {
	"rock": preload("res://scenes/racer/rock.tscn"),
	"car": preload("res://scenes/racer/enemy_car.tscn"),
	"booster": preload("res://scenes/racer/booster.tscn")
}

var OBSTACLES = OBSTACLE_DATA.keys()

export var default_spawn_distance = 500.0
export var default_spawn_variation = 0.2

onready var game_state = get_tree().get_nodes_in_group("racer_state")[0]

var spawn_ready

var spawn_mod = BALANCE.racer["LEVEL_SPAWN_MOD"]
var level_mod = BALANCE.racer["SCORE_DIFFICULTY_THRESHOLD"]

func _ready():
	reset_spawn_time()

func _process(delta):
	spawn_ready -= delta * game_state.car_speed()
	if spawn_ready <= 0:
		spawn_random_object()
		reset_spawn_time()
	
func reset_spawn_time():
	var spawn_distance = default_spawn_distance * pow(spawn_mod, game_state.get_score()/ level_mod)
	var spawn_variation = spawn_distance * default_spawn_variation
	spawn_ready = spawn_distance + rand_range(-spawn_variation, spawn_variation)
	if spawn_ready < 0: spawn_ready = 0

func spawn_random_object():
	var new_obstacle_type = OBSTACLES[randi() % OBSTACLES.size()]
	var new_obstacle = OBSTACLE_DATA[new_obstacle_type].instance()
	var extents = new_obstacle.get_node("Collision").shape.extents
	var bounds = game_state.visible_bounds()
	if new_obstacle_type == "rock":
		new_obstacle.position.x = rand_range(bounds[0] + extents.x, bounds[1] - extents.x)
	else:
		# TODO Hardcoded tile sizes to make sure cars and boosts are on road
		new_obstacle.position.x = rand_range(bounds[0] + extents.x + 64, bounds[1] - extents.x - 64)
	new_obstacle.position.y = -1 * extents.y
	add_child(new_obstacle)