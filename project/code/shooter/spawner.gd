extends Node

const enemies = [
	preload("res://scenes/shooter/enemies/enemy_blitzer.tscn"),
	preload("res://scenes/shooter/enemies/enemy_shooter.tscn"),
	preload("res://scenes/shooter/enemies/meteor.tscn"),
	preload("res://scenes/shooter/enemies/enemy_swiper.tscn")
]

var min_spawn_time = 2
var max_spawn_time = 4

var spawn_countdown = rand_range(min_spawn_time, max_spawn_time)

func _ready():
	pass

func _process(delta):
	spawn_countdown -= delta
	if spawn_countdown <= 0:
		spawn_enemy()
		spawn_countdown = rand_range(min_spawn_time, max_spawn_time)
	
func spawn_enemy():
	var enemy = enemies[randi() % enemies.size()].instance()
	var pos = Vector2()
	var enemy_size = enemy.get_node("Collision").shape.extents
	pos.x = rand_range(enemy_size.x, get_viewport().get_visible_rect().size.x-enemy_size.x)
	pos.y = 0-enemy_size.y
	enemy.position = pos
	$container.add_child(enemy)

