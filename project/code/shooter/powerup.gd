extends Area2D

var velocity = Vector2(0, 200)

func _ready():
	pass

func _process(delta):
	translate(velocity * delta)
	
	if position.y > get_viewport().size.y - $Collision.shape.extents.y:
		queue_free()
	pass
