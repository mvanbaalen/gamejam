extends "res://code/shooter/powerup.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	connect("area_entered", self, "_on_area_entered")
	pass

func _on_area_entered(other):
	if other.is_in_group("ship"):
		other.pickup("spread")
		queue_free()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
