extends Node

const powerups = [
	preload("res://scenes/shooter/speed_powerup.tscn"),
	preload("res://scenes/shooter/spread_powerup.tscn")
]

func _ready():
	var timer = Timer.new()
	timer.set_wait_time(rand_range(8,16))
	timer.set_one_shot(true)
	self.add_child(timer)
	timer.start()
	yield(timer, "timeout")
	timer.queue_free()
	spawn()
	pass

func _process(delta):
	pass

func spawn():
	while true:
		randomize()
		var powerup = powerups[randi() % powerups.size()].instance()
		var pos = Vector2()
		var node_size = powerup.get_node("Collision").shape.extents
		var timer = Timer.new()
		timer.set_wait_time(rand_range(8,16))
		timer.set_one_shot(true)
		self.add_child(timer)
		timer.start()
		pos.x = rand_range(node_size.x, get_viewport().get_visible_rect().size.x-node_size.x)
		pos.y = 0-node_size.y
		powerup.position = pos
		$container.add_child(powerup)
		yield(timer, "timeout")
		timer.queue_free()
	pass
