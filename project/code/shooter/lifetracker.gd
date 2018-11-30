extends GridContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var ship = get_parent().get_parent().get_parent().get_node("Ship")
	ship.connect("armor_changed", self, "_on_armor_changed")
	pass

func _on_armor_changed(armor):
	if get_child_count() > armor:
		get_child(get_child_count()-1).queue_free()
