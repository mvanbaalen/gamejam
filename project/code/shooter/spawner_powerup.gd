extends Node

const powerup = preload("res://scenes/shooter/powerup.tscn")

const powerup_icons = [
	preload("res://graphics/shooter/speed_powerup.png"),
	preload("res://graphics/shooter/spread_powerup.png"),
	preload("res://graphics/shooter/double_powerup_vector.png")
]

const powerup_data = [
	{"type": "speed", "icon": powerup_icons[0]},
	{"type": "spread", "icon": powerup_icons[1]},
	{"type": "double", "icon": powerup_icons[2]}
]

var timer_min = 8
var timer_max = 16
var spawn_timer = 0


func _ready():
	spawn_timer = rand_range(timer_min, timer_max)

func _process(delta):
	spawn_timer -= delta
	if spawn_timer <= 0:
		create_powerup()
		spawn_timer = rand_range(timer_min, timer_max)

func create_powerup():
	var created_powerup = powerup.instance()
	var powerup_info = powerup_data[randi() % powerup_data.size()]
	
	var node_size = created_powerup.get_node("Collision").shape.extents
	created_powerup.position.x = rand_range(node_size.x, get_viewport().get_visible_rect().size.x-node_size.x)
	created_powerup.position.y = 0-node_size.y
	created_powerup.get_node("Sprite").texture = powerup_info["icon"]
	created_powerup.type = powerup_info["type"]
	$container.add_child(created_powerup)
