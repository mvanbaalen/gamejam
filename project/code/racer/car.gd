extends Area2D

const side_speed = 250
const max_speed = 100
const accel_rate = 25

var vert_speed = 0

signal speed_changed

func _ready():
	set_process_input(true)

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
		vert_speed = clamp(vert_speed + delta*accel_rate, 0, max_speed)
	else:
		 vert_speed = clamp(vert_speed - delta*accel_rate, 0, max_speed)
	emit_signal("speed_changed", vert_speed)
	
	#Process Change
	translate(Vector2(direction*side_speed*delta, 0))
	rotation_degrees = rotation_value
	
	#Cleanup
	var view_size = get_viewport().size
	var extents = $Collision.shape.extents
	self.position.x = clamp(self.position.x, extents.x, view_size.x-extents.x)