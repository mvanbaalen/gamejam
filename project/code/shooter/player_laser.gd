extends "res://code/shooter/laser.gd"

func _ready():
	connect("area_entered", self, "_on_area_entered")
	pass

func _on_area_entered(other):
	if other.is_in_group("enemy"):
		other.armor -= 1
		create_flare()
		queue_free()
		
#func _process(delta):
#	pass