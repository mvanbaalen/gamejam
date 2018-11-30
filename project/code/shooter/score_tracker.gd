extends Label
#This is the shooter one

onready var game_state = get_parent().get_parent().get_parent().get_parent()

func _ready():
	game_state.connect("score_changed", self, "_on_score_changed")
	pass

func _on_score_changed(value):
	text = str(value)
