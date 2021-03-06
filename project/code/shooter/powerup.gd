extends Area2D

export var type = ""
var velocity = Vector2(0, 200)


func _ready():
	connect("area_entered", self, "_on_area_entered")
	pass

func _on_area_entered(other):
	if other.is_in_group("ship"):
		other.pickup(type)
		queue_free()
	pass

func _process(delta):
	translate(velocity * delta)
	
	if position.y > get_viewport().size.y - $Collision.shape.extents.y:
		var effects = $Effects
		remove_child(effects)
		effects.get_child(0).emitting = false
		get_parent().add_child(effects)
		queue_free()
