extends Node

onready var game_state = get_tree().get_nodes_in_group("racer_state")[0]

func _ready():
	pass

func _process(delta):
	var movement = game_state.SPEED_MODIFIER * delta * game_state.car_speed()
	$Road1.translate(Vector2(0, movement))
	if $Road1.position.y > get_viewport().size.y:
		$Road1.position.y = -816 + movement * 2
	# We can calculate 816 but I couldn't figure it out
	# Movement * 2 sometimes leads to slightly overlapping tiles
	# But it's better than the slighlty offset tiles!
	
	$Road2.translate(Vector2(0, movement))
	if $Road2.position.y > get_viewport().size.y:
		$Road2.position.y = -816 + movement * 2