extends Node

var left_dirty_bus = 1
var left_clean_bus = 2
var center_bus = 3
var right_clean_bus = 4
var right_dirty_bus = 5
var vol_range = 45

func _ready():
	$LeftDirty.play()
	$Left.play()
	$Center.play()
	$Right.play()
	$RightDirty.play()

func _process(delta):
	var px = get_tree().get_nodes_in_group("ship")[0].position.x
	var cs = get_tree().get_nodes_in_group("racer_state")[0].car_speed()#0 to 100

	AudioServer.set_bus_volume_db(left_clean_bus, px/638*vol_range-vol_range)
	AudioServer.set_bus_volume_db(left_dirty_bus, -vol_range - AudioServer.get_bus_volume_db(left_clean_bus))
#	AudioServer.set_bus_volume_db(master_bus,(1-abs(350-$Player.position.y)/350)*20)
	
	AudioServer.set_bus_volume_db(right_clean_bus,0)#cs/100*vol_range-vol_range)
	AudioServer.set_bus_volume_db(right_dirty_bus, -vol_range - AudioServer.get_bus_volume_db(right_clean_bus))
	print(AudioServer.get_bus_volume_db(right_dirty_bus))
#	AudioServer.set_bus_volume_db(master_bus,(1-abs(350-$Player.position.y)/350)*20)