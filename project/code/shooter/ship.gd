extends Area2D

const laser_scene = preload("res://scenes/shooter/player_laser.tscn")
const ship_speed = 250
const shot_cooldown = 0.4
const fast_cooldown = 0.2

var current_cooldown
var armor = 4 setget set_armor
var cooldown = 0

var speed_active = false
var spread_active = false

signal armor_changed

func _ready():
	set_process_input(true)
	add_to_group("ship")
	self.current_cooldown = shot_cooldown

func _process(delta):
	#Check Input
	var direction = 0
	if Input.is_action_pressed("ui_right"):
		direction += 1
	if Input.is_action_pressed("ui_left"):
		direction -= 1
	if Input.is_action_pressed("ui_accept"):
		shoot()
	
	#Process Changes
	cooldown = clamp(0, cooldown - delta, current_cooldown)
	translate(Vector2(direction*ship_speed*delta, 0))
	
	#Cleanup
	var view_size = get_viewport().size
	var extents = $collision.shape.extents
	self.position.x = clamp(self.position.x, extents.x, view_size.x-extents.x)
	
func shoot():
	if cooldown == 0:
		if spread_active:
			create_laser(0)
			create_laser(20)
			create_laser(-20)
		else:
			create_laser(0)
		$Sounds/Laser.play()	
		cooldown = current_cooldown

func create_laser(angle):
	var laser = laser_scene.instance()
	var origin = $Cannon.get_global_transform().get_origin()
	angle = deg2rad(angle)
	var speed = laser.velocity.y
	laser.position = origin
	laser.velocity = Vector2(sin(angle)*speed, cos(angle)*speed)
	laser.rotation = -angle
	get_parent().add_child(laser)
	
func set_armor(new_value):
	armor = new_value
	emit_signal("armor_changed", armor)
	if armor <= 0: queue_free()
	
func pickup(powerup):
	if powerup == "speed" and not speed_active:
		speed_active = true
		current_cooldown = fast_cooldown
	if powerup == "spread" and not spread_active: spread_active = true
		