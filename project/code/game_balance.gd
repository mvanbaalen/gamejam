extends Node

const racer = {
	"HORIZONTAL_SPEED": 300,
	"SCORE_DIFFICULTY_THRESHOLD": 100,
	"LEVEL_SPAWN_MOD": .9,
}

const shooter = {
	"HORIZONTAL_SPEED": 300,
	"POWERUP_POINT_VALUE": 5,
	"LASER_MOVEMENT_SPEED": 800,
	"SCORE_DIFFICULTY_THRESHOLD": 100,
	"DIFFICULTY_RESPAWN_MOD": .9,
	"DIFFICULTY_SPEED_MOD": 1.2,
	"DIFFICULTY_LIFE_MOD": 1.4
}

func _ready():
	#Weird place for this but here we are
	set_process_input(true)

func _process(delta):
	if Input.is_action_just_pressed("exit_game"):
		get_tree().quit()

