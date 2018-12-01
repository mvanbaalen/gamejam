extends Control

const boost_icon = preload("res://scenes/racer/hud/boost.tscn")
onready var game_state = get_tree().get_nodes_in_group("racer_state")[0]

func _ready():
	get_tree().get_nodes_in_group("player")[0].connect("updated_boosts", self, "_on_updated_boosts")

func _on_updated_boosts(boost_amount):
	#TODO I hate this
	if boost_amount == 3:
		$Boost3.visible = true
		$Boost2.visible = true
		$Boost1.visible = true
	elif boost_amount == 2:
		$Boost3.visible = false
		$Boost2.visible = true
		$Boost1.visible = true
	elif boost_amount == 1:
		$Boost3.visible = false
		$Boost2.visible = false
		$Boost1.visible = true
	elif boost_amount == 0:
		$Boost3.visible = false
		$Boost2.visible = false
		$Boost1.visible = false
