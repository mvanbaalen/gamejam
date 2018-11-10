extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process_input(true)

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		self.position.x +=1
	if Input.is_action_pressed("ui_left"):
		self.position.x -=1
		
	var view_size = get_viewport().size
	var extents = $Collision.shape.extents
	self.position.x = clamp(self.position.x, extents.x, view_size.x-extents.x)