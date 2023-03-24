extends Node3D


@onready var cube_for_instance = load("res://levels/cube_pltaform.tscn")

var current_cube_position_spawn : float = 0
var current_cube_elevation : float = 0


var rng = RandomNumberGenerator.new()


func _ready():
	Events.connect("assign_the_biggest_position", calculate_biggest_position)
	Events.connect("assign_the_biggest_deviation_right", change_cube_deviation)

func create_lines_of_cubes(current_ball_speed):
	var random_elevation : float
	var random_position : float 
	
	
	if current_ball_speed < 5:
		random_position = rng.randi_range(5, 5)
		random_elevation = rng.randi_range(-1, 0)
	elif current_ball_speed >= 5 and current_ball_speed < 12 :
		random_position = rng.randi_range(5, 5) 
		random_elevation = rng.randf_range(-1.5, 0.5)
	else:
		random_position = rng.randi_range(5, 5) 
		random_elevation = rng.randf_range(-2, 1)
	for i in range(7):
		var cube = cube_for_instance.instantiate()
		self.add_child(cube)
		cube.position.z = current_cube_position_spawn + random_position 
#		cube.position.y = current_cube_elevation + random_elevation
#		if random_elevation != 0:
#			cube.rotate_x(PI/random_elevation)
		current_cube_position_spawn = cube.position.z
		current_cube_elevation = cube.position.y
		Events.right_cube_position = cube.position.z
		Events.right_cube_deviation = cube.position.y
		if i == 1:
			cube.position.z = current_cube_position_spawn + random_position + current_ball_speed/2



func delete_all_the_children(ball_position):
	var amount_of_children = self.get_child_count()
	for cube_child in amount_of_children:
		var cube_for_delition = self.get_child(cube_child)
		if cube_for_delition.position.z + 100 < ball_position:
			cube_for_delition.queue_free()
#			print("cube_deleted" + str(cube_for_delition.name))



func calculate_biggest_position(biggest_position):
	current_cube_position_spawn = biggest_position
#	print("right cube pos" , current_cube_position_spawn)


func change_cube_deviation(change_cube_deviation_right):
	current_cube_elevation = change_cube_deviation_right

