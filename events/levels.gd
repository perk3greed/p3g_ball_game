extends Node

var level_variations = {
	1 : "res://levels/level_0-b.tscn",
	2 : "res://levels/test_lvl_2.tscn",
	3 : "res://levels/test_lvl_3.tscn",
	4 : "res://levels/level_4_main.tscn",
	5 : "res://levels/level_5.tscn",
	6 : "res://levels/level6.tscn",
	7 : "res://levels/level_7.tscn",
	8 : "res://levels/level_8.tscn",
	9 : "res://levels/level_9.tscn",
	10 : "res://levels/level_10.tscn",
	11 : "res://levels/level_11.tscn",
	12 : "res://levels/level_12.tscn",
	13 : "res://levels/level_13.tscn", 
	14 : "res://levels/level_14.tscn",
	15 : "res://levels/level15.tscn",
	16 : "res://levels/level_16.tscn",
	17 : "res://levels/level_17.tscn",
	18 : "res://levels/level18.tscn",
	19 : "res://levels/level_19.tscn",
	20 : "res://levels/level_20.tscn",
	21 : "res://levels/level_21.tscn",
	22 : "res://levels/level22.tscn",
	23 : "res://levels/level23.tscn"
	
	
	
	
	
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
