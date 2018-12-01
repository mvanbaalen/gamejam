extends Node

var shooter_data
var racer_data
	
func _ready():
	randomize()
	clear_data()
	
func clear_data():
	shooter_data = {"Score": 0}
	racer_data = {"Score": 0}