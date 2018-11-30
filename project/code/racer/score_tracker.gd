extends Label
# This is the car one

onready var game_state = get_tree().get_nodes_in_group("racer_state")[0]

func _ready():
	pass

func _process(delta):
	text = str(game_state.get_score())
