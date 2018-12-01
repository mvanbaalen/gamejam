extends HBoxContainer

const mini_icon = preload("res://scenes/shooter/hud/powerup_icon.tscn")

#TODO I'd like these to be defined elsewhere and all things pull from them
const powerup_textures = {
	"speed": preload("res://graphics/shooter/speed_powerup.png"),
	"double": preload("res://graphics/shooter/double_powerup.png"),
	"spread": preload("res://graphics/shooter/spread_powerup.png")
}

func _ready():
	var ship = get_parent().get_parent().get_parent().get_node("Ship")
	ship.connect("got_powerup", self, "_on_got_powerup")
	ship.connect("took_damage", self, "_on_took_damage")

func _on_got_powerup(powerup_name):
	#TODO: Should the reset the position in the queue?
	if not has_node("PowerupIcon_" + powerup_name):
		var powerup_icon = mini_icon.instance()
		powerup_icon.texture = powerup_textures[powerup_name]
		powerup_icon.name += "_" + powerup_name
		powerup_icon.rect_scale = Vector2(0.5, 0.5)
		add_child(powerup_icon)

func _on_took_damage(powerup_lost):
	var lost_powerup = get_node("PowerupIcon_" + powerup_lost)
	lost_powerup.queue_free()
