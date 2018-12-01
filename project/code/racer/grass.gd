extends Area2D

func _ready():
	connect("area_entered", self, "_on_area_entered")
	connect("area_exited", self, "_on_area_exited")
	
func _on_area_entered(other):
	if other.is_in_group("player"):
		other.set_on_grass()

func _on_area_exited(other):
	if other.is_in_group("player"):
		other.set_off_grass()

