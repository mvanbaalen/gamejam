extends "res://code/shooter/enemy.gd"

func _ready():
	if randi()%2+1 == 1: velocity.x = -velocity.x #Random number between 1 and 2

func _process(delta):
	# If I'm off screen horizontally, move down and swipe again
	if position.x + $Collision.shape.extents.x <= 0:
		turn_around()
	if position.x - $Collision.shape.extents.x >= get_viewport().size.x:
		turn_around()

func turn_around():
	position.y += 128
	velocity.x = -velocity.x
