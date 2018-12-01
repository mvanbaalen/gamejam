extends "res://code/shooter/enemy.gd"

const laser_scene = preload("res://scenes/shooter/enemies/enemy_laser.tscn")

export var shot_cooldown = 1.5
export var shot_variability = .2
export var current_cooldown = 0

func _ready():
	if randi()%2+1 == 1: velocity.x = -velocity.x #Random number between 1 and 2
	reset_cooldown()

func _process(delta):
	# Turn around when I hit a wall
	if position.x <= 0 + $Collision.shape.extents.x:
		velocity.x = -velocity.x
	if position.x >= get_viewport().size.x - $Collision.shape.extents.x:
		velocity.x = -velocity.x
	#Check if I can shoot yet, then do it
	current_cooldown -= delta
	if current_cooldown <= 0: shoot()

func shoot():
	var laser = laser_scene.instance()
	laser.position = $Cannon.get_global_transform().get_origin()
	get_parent().add_child(laser)
	game_state.get_node("Sounds/Laser").play()
	reset_cooldown()
	
func reset_cooldown():
	var mod = shot_cooldown * shot_variability
	current_cooldown = rand_range(shot_cooldown - mod, shot_cooldown + mod)