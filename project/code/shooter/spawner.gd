extends Node

const enemies = [
	preload("res://scenes/shooter/enemy_basic.tscn"),
	preload("res://scenes/shooter/enemy_shooter.tscn"),
	preload("res://scenes/shooter/meteor.tscn")
]

func _ready():
	spawn()
	pass

func _process(delta):
	pass
	
func spawn():
	while true:
		randomize()
		var enemy = enemies[randi() % enemies.size()].instance()
		var pos = Vector2()
		var enemy_size = enemy.get_node("Collision").shape.extents
		var timer = Timer.new()
		timer.set_wait_time(rand_range(2,4))
		timer.set_one_shot(true)
		self.add_child(timer)
		timer.start()
		pos.x = rand_range(enemy_size.x, get_viewport().get_visible_rect().size.x-enemy_size.x)
		pos.y = 0-enemy_size.y
		enemy.position = pos
		$container.add_child(enemy)
		yield(timer, "timeout")
		timer.queue_free()
	pass
