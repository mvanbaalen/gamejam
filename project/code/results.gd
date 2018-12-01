extends Node

var shooter_data
	
func _ready():
	randomize()
	clear_data()
	
func clear_data():
	shooter_data = {
		"Score": 0,
		"Shots": 0,
		"Powerups": 0
	}