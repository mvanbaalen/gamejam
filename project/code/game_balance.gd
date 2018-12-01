extends Node

const racer = {
	"HORIZONTAL_SPEED": 300,
}

const shooter = {
	"HORIZONTAL_SPEED": 300,
	"POWERUP_POINT_VALUE": 5,
	"LASER_MOVEMENT_SPEED": 800,
}

func _ready():
	#Weird place for this but here we are
	set_process_input(true)

func _process(delta):
	if Input.is_action_just_pressed("exit_game"):
		get_tree().quit()

