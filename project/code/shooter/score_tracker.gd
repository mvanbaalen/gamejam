extends Label
#This is the shooter one

onready var game_state = get_tree().get_nodes_in_group("shooter_state")[0]

func _ready():
	game_state.connect("score_changed", self, "_on_score_changed")

func _on_score_changed(value):
	text = str(value)