extends Node

var level_variations = {
	1 : "res://levels/level_0-b.tscn",
	2 : "res://levels/test_lvl_2.tscn",
	3 : "res://levels/test_lvl_3.tscn",
	4 : "res://levels/level_4_main.tscn"
}

var spawn_points_for_ball = {
	1 : Vector3(0, 15, -15), 
	2 : Vector3(0, 20, -100),
	3 : Vector3(0, 10, -90),
	4 : Vector3(0,10,0)
	
	
}

var current_level_is : int 


var current_checkpoint : Vector3 = Vector3.ZERO


var spawn_points : Vector3 = Vector3.ZERO
