extends Sprite

export var speed = 100

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	translate(Vector2(0, speed*delta))
	if position.y > get_viewport().get_visible_rect().size.y+16:
		queue_free()
