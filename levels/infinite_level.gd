extends Node3D

@onready var cube_for_instance = load("res://levels/cube_pltaform.tscn")

var ball_position : float
var distant_cube : float = 0
var current_cube_position_spawn_middle : float = 0
var current_cube_elevation_left : float = 0
var current_cube_elevation_right : float = 0
var current_cube_elevation_middle : float = 0 
var rng = RandomNumberGenerator.new()
var current_ball_speed = Events.speed_for_export
var distant_cube_for_parralels = 0
var current_cube_position_spawn_left : float = 0
var current_cube_position_spawn_right : float = 0

var biggest_position :float = 0
var biggest_deviation :float = 0

var global_cube_position_left : float = 0
var global_cube_position_right : float = 0
var global_cube_position_middle : float = 0

var global_cube_deviation_left : float = 0
var global_cube_deviation_right : float = 0
var global_cube_deviation_middle : float = 0

var change_cube_deviation_left : float = 0
var change_cube_deviation_right : float = 0
var change_cube_deviation_middle : float = 0


signal assign_the_biggest_deviation_left(change_cube_deviation_left)
signal assign_the_biggest_deviation_right(change_cube_deviation_right)
signal assign_the_biggest_deviation_middle(change_cube_deviation_middle)
signal assign_the_biggest_position(biggest_position)

func _ready():
	pass

func _process(_delta):

	
	current_ball_speed = Events.speed_for_export
	ball_position = Events.ball_distance_z
	if ball_position > global_cube_position_middle - 300 and ball_position > global_cube_position_right - 300 and ball_position > global_cube_position_left - 300 :
		self.spawn_cubes()
		self.set_biggest_position()
		$cubes_container_right.delete_all_the_children(ball_position)
		$cubes_container_left.delete_all_the_children(ball_position)
		$cubes_container_middle.delete_all_the_children(ball_position)

func spawn_cubes():
	var count_the_lines : int = 0

	if current_ball_speed >= 0 and current_ball_speed < 3:
		count_the_lines = 3
	elif current_ball_speed >= 3 and current_ball_speed <15 :
		count_the_lines = 2
	else:
		count_the_lines =1
	
	self.create_parralell_lines(count_the_lines)

func create_parralell_lines(count_the_lines):
	var choosen_line : int = 0
	if count_the_lines == 1:
		choosen_line = rng.randi_range(-1,1)
		if choosen_line == -1:
			$cubes_container_left.create_lines_of_cubes(current_ball_speed)
#			print("i am doing 11")
		elif choosen_line == 0:
			$cubes_container_middle.create_lines_of_cubes(current_ball_speed)
#			print("i am doing 12")
		elif choosen_line == 1:
			$cubes_container_right.create_lines_of_cubes(current_ball_speed)
#			print("i am doing 13")
	elif count_the_lines == 2:
		choosen_line = rng.randi_range(-1,1)
		if choosen_line == -1:
			$cubes_container_left.create_lines_of_cubes(current_ball_speed)
			$cubes_container_middle.create_lines_of_cubes(current_ball_speed)
#			print("i am doing 21")
		elif choosen_line == 0:
			$cubes_container_middle.create_lines_of_cubes(current_ball_speed)
			$cubes_container_right.create_lines_of_cubes(current_ball_speed)
#			print("i am doing 22")
		elif choosen_line == 1:
			$cubes_container_right.create_lines_of_cubes(current_ball_speed)
			$cubes_container_left.create_lines_of_cubes(current_ball_speed)
#			print("i am doing 23")
	elif count_the_lines == 3:
#		print("i am doing 3")
		$cubes_container_left.create_lines_of_cubes(current_ball_speed)
		$cubes_container_middle.create_lines_of_cubes(current_ball_speed)
		$cubes_container_right.create_lines_of_cubes(current_ball_speed)
	
	

func set_biggest_position():
	global_cube_position_middle = Events.middle_cube_position
	global_cube_position_left = Events.left_cube_position
	global_cube_position_right = Events.right_cube_position
	
	if global_cube_position_right > global_cube_position_left and global_cube_position_right > global_cube_position_middle:
		biggest_position = global_cube_position_right
		Events.emit_signal("assign_the_biggest_position", biggest_position)
	elif global_cube_position_left > global_cube_position_right and global_cube_position_left > global_cube_position_middle:
		biggest_position = global_cube_position_left
		Events.emit_signal("assign_the_biggest_position", biggest_position)
	elif global_cube_deviation_middle > global_cube_deviation_left and global_cube_deviation_middle > global_cube_deviation_right:
		biggest_position = global_cube_position_middle
		Events.emit_signal("assign_the_biggest_position", biggest_position)
	
	global_cube_deviation_left = Events.left_cube_deviation
	global_cube_deviation_right = Events.right_cube_deviation
	global_cube_deviation_middle = Events.middle_cube_deviation
	
	if global_cube_deviation_right > global_cube_deviation_left and global_cube_deviation_right > global_cube_deviation_middle :
		change_cube_deviation_left = (global_cube_deviation_right - global_cube_deviation_left)
		change_cube_deviation_middle = (global_cube_deviation_right - global_cube_deviation_middle)
		Events.emit_signal("assign_the_biggest_deviation_left" , global_cube_deviation_right)
		Events.emit_signal("assign_the_biggest_deviation_middle" , global_cube_deviation_right)
		print("change_cube_deviation_left===", int(change_cube_deviation_left))
		print("change_cube_deviation_middle===", int(change_cube_deviation_middle))
		
		
	elif global_cube_deviation_left > global_cube_deviation_right and global_cube_deviation_left > global_cube_deviation_middle:
		change_cube_deviation_right = (global_cube_deviation_left - global_cube_deviation_right)
		change_cube_deviation_middle = (global_cube_deviation_left - global_cube_deviation_middle)
		Events.emit_signal("assign_the_biggest_deviation_right" , global_cube_deviation_left)
		Events.emit_signal("assign_the_biggest_deviation_middle" , global_cube_deviation_left)
		print("change_cube_deviation_right===", int(change_cube_deviation_right))
		print("change_cube_deviation_middle===", int(change_cube_deviation_middle))
		
	elif global_cube_deviation_middle > global_cube_deviation_left and global_cube_deviation_middle > global_cube_deviation_right :
		change_cube_deviation_right = (global_cube_deviation_middle - global_cube_deviation_right)
		change_cube_deviation_left = (global_cube_deviation_middle - global_cube_deviation_left)
		Events.emit_signal("assign_the_biggest_deviation_left" , global_cube_deviation_middle)
		Events.emit_signal("assign_the_biggest_deviation_right" , global_cube_deviation_middle)
		print("change_cube_deviation_left===", int(change_cube_deviation_left))
		print("change_cube_deviation_right===", int(change_cube_deviation_right))
		
#	print("change_cube_deviation_left===", int(change_cube_deviation_left))
#	print("change_cube_deviation_right===", int(change_cube_deviation_right))
#	print("change_cube_deviation_middle===", int(change_cube_deviation_middle))
#	print("biggest_position==", biggest_position)
