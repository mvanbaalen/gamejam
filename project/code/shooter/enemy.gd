extends Area2D

export var base_point_value = 5
export var velocity = Vector2()
export var armor = 2 setget set_armor
const explosion_scene = preload("res://scenes/shooter/explosion.tscn")

onready var game_state = get_parent().get_parent().get_parent()

func _ready():
	add_to_group("enemy")
	connect("area_entered", self, "_on_area_entered")

func _process(delta):
	translate(velocity * delta)
	if (position.y-$Collision.shape.extents.y >= get_viewport().size.y):
		save_effects()
		queue_free()
		
func set_armor(new_value):
	armor = new_value
	if armor <= 0: die()
	
func _on_area_entered(other):
	if other.is_in_group("ship"):
		other.take_damage()
		die()
	
func die():
	game_state.add_score(base_point_value)
	save_effects()
	explode()
	#TODO Play sound - container node sounds are appropriate?
	queue_free()

func explode():
	var explosion = explosion_scene.instance()
	explosion.position = self.position
	explosion.emitting = true
	explosion.one_shot = true
	get_parent().add_child(explosion)
	
func save_effects():
	var effects = $Effects
	if effects != null:
		# This gets called twice when enemies die in two ways at once which sometimes happens
		# I'd like to fix that in the future of course
		for effect in effects.get_children():
			effect.emitting = false
			#This stupid effect WILL NOT STOP EMITTING
			if effect.name == "Wobble": effect.queue_free()
		remove_child(effects)
		get_parent().add_child(effects)
		