extends Node2D

onready var game_state = self

var score = 0 setget add_score

signal score_changed

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func add_score(new_value):
	score += new_value
	emit_signal("score_changed", score)
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
