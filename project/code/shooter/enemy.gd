extends Area2D

export var velocity = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	translate(velocity * delta)
	if position.y-$Collision.shape.extents.y >= get_viewport().size.y:
		queue_free()