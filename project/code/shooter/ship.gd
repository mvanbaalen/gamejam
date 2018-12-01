extends Area2D

const laser_scene = preload("res://scenes/shooter/player_laser.tscn")
var ship_speed = BALANCE.shooter["HORIZONTAL_SPEED"]
const shot_cooldown = 0.7
const fast_cooldown = 0.35

var cooldown = 0
var active_powerups = []

signal shot_laser
signal got_powerup
signal took_damage

onready var game_state = get_parent()

func _ready():
	set_process_input(true)
	add_to_group("ship")
	self.position.x = (get_viewport().size.x / 2)

func _process(delta):
	cooldown -= delta
	if Input.is_action_pressed("ui_accept") and cooldown <= 0:
		shoot()
	translate(Vector2(get_direction()*ship_speed*delta, 0))
	
	#Cleanup
	var view_size = get_viewport().size
	var extents = $collision.shape.extents
	self.position.x = clamp(self.position.x, extents.x, view_size.x-extents.x)

func get_direction():
	var direction = 0
	if Input.is_action_pressed("ui_right"): direction += 1
	if Input.is_action_pressed("ui_left"): direction -= 1
	return direction

func shoot():
	var cannon_location = $Cannon.get_global_transform().get_origin()
	if active_powerups.has("double"):
		create_laser(0, cannon_location - Vector2(8, 0))
		create_laser(0, cannon_location + Vector2(8, 0))
	else:
		create_laser(0, cannon_location)
	if active_powerups.has("spread"):
		create_laser(-30, cannon_location - Vector2(8, 0))
		create_laser(30, cannon_location + Vector2(8, 0))
	
	emit_signal("shot_laser")
	$Sounds/Laser.play()
	if active_powerups.has("speed"): cooldown = fast_cooldown
	else: cooldown = shot_cooldown

func create_laser(angle, origin):
	var laser = laser_scene.instance()
	angle = deg2rad(angle)
	var speed = BALANCE.shooter["LASER_MOVEMENT_SPEED"]
	laser.position = origin
	laser.velocity = Vector2(sin(angle)*speed, -cos(angle)*speed)
	laser.rotation = angle
	get_parent().add_child(laser)
	
func take_damage():
	if active_powerups.empty():
		die()
	else:
		var sound = game_state.get_node("Sounds/ShipDamage")
		sound.play()
		var lost_powerup = active_powerups.pop_front()
		emit_signal("took_damage", lost_powerup)
		
	
func die():
	#TODO: Explode?
	queue_free()
	#TODO: Better transition to menu
	get_tree().change_scene("res://scenes/results.tscn")

func pickup(powerup):
	if not active_powerups.has(powerup): active_powerups.append(powerup)
	game_state.add_score(BALANCE.shooter["POWERUP_POINT_VALUE"])
	emit_signal("got_powerup", powerup)