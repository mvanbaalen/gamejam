extends Particles2D

var sprite_image
var sprite_size
var interval

func _ready():
	sprite_image = get_parent().get_parent().get_node("Sprite").texture.get_data()
	sprite_size = sprite_image.get_size()
	
func _process(delta):
	var rx = int(rand_range(0, sprite_size.x))
	var ry = int(rand_range(0, sprite_size.y))
	sprite_image.lock()
	var p_color = sprite_image.get_pixel(rx,ry)
	sprite_image.unlock()
	self.process_material.color = p_color