extends Label

onready var game_state = get_tree().get_nodes_in_group("racer_state")[0]

func _ready():
	pass
	
func _process(delta):
	text = str(floor(game_state.car_speed()))
