extends Area2D

const side_speed = 250
const max_speed = 100
const accel_rate = 25

var vert_speed = 0 setget set_speed
onready var game_state = get_tree().get_nodes_in_group("racer_state")[0]

signal speed_changed

func _ready():
	set_process_input(true)
	add_to_group("player")
	print("Viewport Size x " + str(get_viewport().size.x))
	print("Viewport Rect Position x " + str(get_viewport().get_visible_rect().position.x))
	print("Viewport Rect Size x " + str(get_viewport().get_visible_rect().size.x))

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

func set_speed(new_value):
	vert_speed = new_value
	emit_signal("speed_changed", vert_speed)
	
func hit_obstacle():
	set_speed(0)