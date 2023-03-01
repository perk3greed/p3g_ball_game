extends Node

var level_variations = {
	1 : "res://levels/level_0-b.tscn", 
	2 : "res://levels/test_lvl_2.tscn"
	
}

var spawn_points_for_ball = {
	1 : Vector3(0, 15, -15), 
	2 : Vector3(0, 15, -30)
	
	
	
	
}

var current_level_is : int 


var current_checkpoint : Vector3 = Vector3.ZERO


var spawn_points : Vector3 = Vector3.ZERO
