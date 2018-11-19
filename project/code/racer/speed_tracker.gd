extends Label

func _ready():
	var car = get_parent().get_parent().get_parent().get_node("car")
	car.connect("speed_changed", self, "_on_speed_changed")
	pass

func _on_speed_changed(value):
	text = str(floor(value))
