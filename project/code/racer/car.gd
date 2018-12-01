extends Area2D

var side_speed = BALANCE.racer["HORIZONTAL_SPEED"]
const INITIAL_MAX_SPEED = 100
const accel_rate = 25

const off_road_multiplier = .5
const off_road_accel_rate = -30

var max_speed = INITIAL_MAX_SPEED
var vert_speed = 0 setget set_speed
var boosts = 0
var on_road = true
var on_grass = false

onready var game_state = get_tree().get_nodes_in_group("racer_state")[0]

signal speed_changed

func _ready():
	set_process_input(true)
	add_to_group("player")

func _process(delta):
	#Check Input
	var direction = 0
	var rotation_value = 0
	
	if Input.is_action_pressed("ui_right"):
		direction += 1
		rotation_value = 20
	if Input.is_action_pressed("ui_left"):
		direction -= 1
		rotation_value = -20
	
	check_acceleration_and_set_speed(delta)
	if Input.is_action_pressed("ui_accept"):
		set_speed(clamp(vert_speed + delta*accel_rate, 0, max_speed))
	else:
		set_speed(clamp(vert_speed - delta*accel_rate, 0, max_speed))
	
	#Process Change
	translate(Vector2(direction*side_speed*delta, 0))
	rotation_degrees = rotation_value
	
	#Cleanup
	var view_x_min = game_state.camera_object.position.x - (get_viewport().size.x / 2)
	var view_x_max = (get_viewport().size.x / 2) + game_state.camera_object.position.x
	var extents = $Collision.shape.extents
	self.position.x = clamp(self.position.x, view_x_min + extents.x, view_x_max - extents.x)

func regular_driving():
	return on_road and not on_grass

func check_acceleration_and_set_speed(delta):
	var current_rate = 0
	if Input.is_action_pressed("ui_accept"): current_rate += accel_rate
	var current_max = max_speed
	if not on_road:
		current_rate += off_road_accel_rate
		current_max = max_speed * off_road_multiplier
	var speed_change = delta * current_rate
	set_speed(clamp(vert_speed + speed_change, 0, max_speed))

func set_speed(new_value):
	vert_speed = new_value
	
func hit_obstacle():
	var sound = game_state.get_node("Sounds/Crash1")
	sound.play()
	set_speed(0)
	if boosts <= 0:
		queue_free()
		#TODO: Better transition to menu
		game_state.update_results()
		get_tree().change_scene("res://scenes/results.tscn")
	else:
		boosts -= 1
		update_boost_speed()
	
func hit_boost():
	randomize()
	var sfx = rand_range(0,2)
	var sound = game_state.get_node("Sounds/Speedup1")
	if sfx < 1:
		sound = game_state.get_node("Sounds/Speedup1")
	elif sfx < 2:
		sound = game_state.get_node("Sounds/Speedup2")
	else:
		sound = game_state.get_node("Sounds/Speedup3")
	sound.play()
	if boosts < 3: boosts += 1
	update_boost_speed()
	game_state.add_score(10)
	game_state.boosts_hit += 1
	#TODO: SOUND?
	#TODO Signal here?
	
func update_boost_speed():
	if boosts == 1:max_speed = 120
	if boosts == 2:max_speed = 150
	if boosts == 3:max_speed = 200
	
func set_on_road():
	on_road = true
	
func set_off_road():
	on_road = false
	
func set_on_grass():
	on_grass = true
	
func set_off_grass():
	on_grass = false
