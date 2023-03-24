extends Node

var speed_for_export := 0
var speed_score_exported
var speed_counted_score
var score_rise_to_style
var positions 
var rotations_for_camera
var ball_distance_z := 0
var current_most_distant_cube : float = 0

var middle_cube_position : float = 0 
var left_cube_position : float = 0
var right_cube_position : float = 0 

var middle_cube_deviation : float = 0
var left_cube_deviation : float = 0
var right_cube_deviation : float = 0


signal set_camera
signal button_for_lvls_pressed(level_of_button) 
signal out_of_the_bounds
signal ball_is_out_of_bounds
signal assign_the_biggest_position(biggest_position)

signal assign_the_biggest_deviation_left(change_cube_deviation_left)
signal assign_the_biggest_deviation_right(change_cube_deviation_right)
signal assign_the_biggest_deviation_middle(change_cube_deviation_middle)
