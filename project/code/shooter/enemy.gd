extends Area2D

export var base_point_value = 5
export var velocity = Vector2()
export var armor = 0.0
const explosion_scene = preload("res://scenes/shooter/explosion.tscn")

var level_mod = BALANCE.shooter["SCORE_DIFFICULTY_THRESHOLD"]
var speed_mod = BALANCE.shooter["DIFFICULTY_SPEED_MOD"]
var life_mod = BALANCE.shooter["DIFFICULTY_LIFE_MOD"]

onready var game_state = get_tree().get_nodes_in_group("shooter_state")[0]

func _ready():
	add_to_group("enemy")
	connect("area_entered", self, "_on_area_entered")
	var level = int(game_state.score / level_mod)
	var mod = pow(speed_mod, level)
	var life_change = pow(life_mod, level)
	velocity = Vector2(velocity.x * mod, velocity.y * mod)
	armor = int(armor * life_change)

func _process(delta):
	translate(velocity * delta)
	if (position.y-$Collision.shape.extents.y >= get_viewport().size.y):
		save_effects()
		queue_free()
	
func take_hit():
	game_state.get_node("Sounds/EnemyDamage").play()
	armor -= 1
	if armor <= 0: die()
	
func _on_area_entered(other):
	if other.is_in_group("ship"):
		other.take_damage()
		die()

func die():
	game_state.add_score(base_point_value)
	save_effects()
	explode()
	game_state.get_node("Sounds/EnemyDie").play()
	queue_free()

func explode():
	var explosion = explosion_scene.instance()
	explosion.position = self.position
	explosion.emitting = true
	explosion.one_shot = true
	get_parent().add_child(explosion)
	
func save_effects():
	if has_node("Effects"):
		# This gets called twice when enemies die in two ways at once which sometimes happens
		# I'd like to fix that in the future of course
		var effects = $Effects
		for effect in effects.get_children():
			effect.emitting = false
			#This stupid effect WILL NOT STOP EMITTING
			if effect.name == "Wobble": effect.queue_free()
		remove_child(effects)
		get_parent().add_child(effects)
		