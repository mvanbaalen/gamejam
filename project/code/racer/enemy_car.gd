extends Area2D

export var vert_speed = 80

onready var game_state = get_tree().get_nodes_in_group("racer_state")[0]

func _ready():
	add_to_group("obstacle")
	connect("area_entered", self, "_on_area_entered")

func _process(delta):
	translate(Vector2(0, delta * game_state.SPEED_MODIFIER * (game_state.car_speed() - vert_speed)))
	if (position.y-$Collision.shape.extents.y >= get_viewport().size.y):
		game_state.obstacle_avoided()
		queue_free()
		
	
func _on_area_entered(other):
	if other.is_in_group("player"):
		other.hit_obstacle()
		#Explode
		queue_free()
	pass
