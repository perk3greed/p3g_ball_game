extends Node

var collided_cube_ref : StaticBody3D

var speed_for_export := 0
#var speed_score_exported := 0
var speed_counted_score
var score_rise_to_style
var positions 
var rotations_for_camera
var ball_distance_z := 0
var current_most_distant_cube : float = 0
var speed_for_generations : float = 0
var difficulty_level : float = 0

var style_exported :float = 0
var style_counter_exported :String = ""
var style_counter_additive_exported :float = 0

var speed_limit_exported : float = 0
var biggest_value_exported :float = 0

var airtime_exported :int = 0 
var speed_for_style_exported :int = 0
var bounds_for_style_exported :int = 0
var combo_for_style_exported :int = 0
var part_of_style_exported : float = 0










signal sky_exited
signal sky_entered


signal bounced_cube(collided_cube_ref)

signal set_camera
signal button_for_lvls_pressed(level_of_button) 
signal out_of_the_bounds
signal ball_is_out_of_bounds

signal sonic_entered
