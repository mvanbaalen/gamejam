extends Area2D

const laser_scene = preload("res://scenes/shooter/player_laser.tscn")

func _ready():
	set_process_input(true)

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		self.position.x +=1
	if Input.is_action_pressed("ui_left"):
		self.position.x -=1
	if Input.is_action_just_pressed("ui_accept"):
		shoot()
		
	var view_size = get_viewport().size
	var extents = $collision.shape.extents
	self.position.x = clamp(self.position.x, extents.x, view_size.x-extents.x)
	
func shoot():
	create_laser($Cannon.get_global_transform().get_origin())

func create_laser(pos):
	var laser = laser_scene.instance()
	laser.position = pos
	get_parent().add_child(laser)
	pass