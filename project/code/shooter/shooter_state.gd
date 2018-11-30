extends Node2D

onready var game_state = self

var score = 0 setget add_score
var shots_fired = 0
var powerups = 0

signal score_changed

func _ready():
	$Ship.connect("shot_laser", self, "_on_shot_laser")
	$Ship.connect("got_powerup", self, "_on_got_powerup")
	
func add_score(new_value):
	score += new_value
	emit_signal("score_changed", score)

func update_results():
	results.shooter_data["Score"] = score
	results.shooter_data["Shots"] = shots_fired
	results.shooter_data["Powerups"] = powerups

func _on_shot_laser():
	shots_fired += 1
	
func _on_got_powerup():
	powerups += 1
