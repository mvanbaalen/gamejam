extends Sprite

export var direction = Vector2(0, 1)
export var speed = 100

func _ready():
	modulate = Color(1, 1, 1, rand_range(0, 1))

func _process(delta):
	translate(Vector2(direction.x * speed * delta, direction.y * speed * delta))
	if position.y > get_viewport().get_visible_rect().size.y+16:
		queue_free()
