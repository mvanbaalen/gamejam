extends Area2D

const laser_scene = preload("res://scenes/shooter/player_laser.tscn")
const ship_speed = 250
const shot_cooldown = 0.7
const fast_cooldown = 0.35

var armor = 4 setget set_armor
var cooldown = 0
var speed_active = false
var spread_active = false
var double_active = false

signal armor_changed

onready var game_state = get_parent()

func _ready():
	set_process_input(true)
	add_to_group("ship")
	self.position.x = get_viewport().size.x / 2

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
	if double_active:
		create_laser(0, cannon_location - Vector2(8, 0))
		create_laser(0, cannon_location + Vector2(8, 0))
	else:
		create_laser(0, cannon_location)
	if spread_active:
		create_laser(30, cannon_location - Vector2(8, 0))
		create_laser(-30, cannon_location + Vector2(8, 0))
		
	$Sounds/Laser.play()
	if speed_active: cooldown = fast_cooldown
	else: cooldown = shot_cooldown

func create_laser(angle, origin):
	var laser = laser_scene.instance()
	angle = deg2rad(angle)
	var speed = laser.velocity.y
	laser.position = origin
	laser.velocity = Vector2(sin(angle)*speed, cos(angle)*speed)
	laser.rotation = -angle
	get_parent().add_child(laser)
	
func set_armor(new_value):
	armor = new_value
	emit_signal("armor_changed", armor)
	if armor <= 0:
		queue_free()
		#TODO: Better transition to menu
		get_tree().change_scene("res://scenes/menu.tscn")
	
func pickup(powerup):
	if powerup == "speed" and not speed_active: speed_active = true
	if powerup == "spread" and not spread_active: spread_active = true
	if powerup == "double" and not double_active: double_active = true
		