extends Area2D

export var velocity = Vector2()
const flare_scene = preload("res://scenes/shooter/flare.tscn")

func _ready():
	create_flare()
	yield($Visibility, "screen_exited")
	queue_free()
	pass

func _process(delta):
	translate(velocity * delta)
	pass
	
func create_flare():
	var flare = flare_scene.instance()
	flare.position = position
	get_parent().add_child(flare)
	pass
