extends "res://code/shooter/enemy.gd"

const laser_scene = preload("res://scenes/shooter/enemy_laser.tscn")

func _ready():
	randomize()
	if randi()%2+1 == 1: velocity.x = -velocity.x #Random number between 1 and 2
	
	var timer = Timer.new()
	timer.set_wait_time(1)
	timer.set_one_shot(true)
	self.add_child(timer)
	timer.start()
	yield(timer, "timeout")
	timer.queue_free()
	shoot()
	pass

func _process(delta):
	if position.x <= 0 + $Collision.shape.extents.x:
		velocity.x = -velocity.x
	if position.x >= get_viewport().size.x - $Collision.shape.extents.x:
		velocity.x = -velocity.x
	pass

func shoot():
	while true:
		var laser = laser_scene.instance()
		laser.position = $Cannon.get_global_transform().get_origin()
		get_parent().add_child(laser)
		$Sound/Laser.play()
		
		var timer = Timer.new()
		timer.set_wait_time(1.5)
		timer.set_one_shot(true)
		self.add_child(timer)
		timer.start()
		yield(timer, "timeout")
		timer.queue_free()

	pass