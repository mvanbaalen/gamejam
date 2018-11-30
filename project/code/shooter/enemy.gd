extends Area2D

export var velocity = Vector2()
export var armor = 2 setget set_armor
const explosion_scene = preload("res://scenes/shooter/explosion.tscn")

func _ready():
	add_to_group("enemy")
	connect("area_entered", self, "_on_area_entered")
	pass

func _process(delta):
	translate(velocity * delta)
	if (position.y-$Collision.shape.extents.y >= get_viewport().size.y):
	#or position.x-$Collision.shape.extents.x >= get_viewport().size.x
	#or position.x+$Collision.shape.extents.x <= get_viewport().size.x):
		queue_free()
		
func set_armor(new_value):
	armor = new_value
	if armor <= 0:
		explode()
		queue_free()
	pass
	
func _on_area_entered(other):
	if other.is_in_group("ship"):
		other.armor -= 1
		queue_free()
	pass
	
func explode():
	var explosion = explosion_scene.instance()
	explosion.position = self.position
	explosion.emitting = true
	explosion.one_shot = true
	get_parent().add_child(explosion)
	pass