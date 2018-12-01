extends "res://code/shooter/enemy.gd"

export var rotation_velocity = 10

func _ready():
	pass

func _process(delta):
	rotation_degrees += delta * rotation_velocity