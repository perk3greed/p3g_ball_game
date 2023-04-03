extends Node3D


var ball_position := 0 
var platform := load("res://levels/3d models/long_board.tscn")
var magnet := load("res://meshes/long_magnet.tscn")
var sonic_circle := load("res://meshes/sonic_torus.tscn")
var booster := load("res://meshes/long_booster.tscn")
var barrier := load("res://meshes/barrier.tscn")


var distant_platform_left := 0
var distant_platform_right := 0
var distant_platform_middle := 0
var distant_nothing := 0
var rng = RandomNumberGenerator.new()
var previous_platform :int 

var current_difficulty_max :int
var current_difficulty_min :int
var current_difficulty_mode :int

var current_score :int


var most_distant_platform := 0
var biggest_value := 0



func _process(delta):
	
	Events.biggest_value_exported = biggest_value
	ball_position = Events.ball_distance_z
	var spawn_distance_fog : int = 200
	
	
	if biggest_value - spawn_distance_fog < ball_position * 1.064 :
		
		current_score = int((Events.style_exported))
		if current_score < 1000:
			current_difficulty_mode = 0
			current_difficulty_max = 8
			current_difficulty_min = 8
			spawn_distance_fog = 300
		if current_score >= 1000 and current_score < 10000:
			current_difficulty_mode = 1
			current_difficulty_max = 8
			current_difficulty_min = 5
			spawn_distance_fog = 500
		if current_score >= 10000 and current_score < 30000:
			current_difficulty_mode = 2
			current_difficulty_max = 7
			current_difficulty_min = 2
			spawn_distance_fog = 600
		if current_score >= 30000 and current_score < 60000:
			current_difficulty_mode = 3
			current_difficulty_max = 4
			current_difficulty_min = 2
			spawn_distance_fog = 1000
		if current_score >= 60000:
			current_difficulty_mode = 4
			current_difficulty_max = 4
			current_difficulty_min = 1 
			spawn_distance_fog = 1200
		
		var my_random_number = rng.randi_range(current_difficulty_min, current_difficulty_max)
		if my_random_number == 1 and previous_platform == 1:
			my_random_number = rng.randi_range(current_difficulty_min, current_difficulty_max)
			print("zero_repit")
			if my_random_number == 1 and previous_platform == 1:
				my_random_number = rng.randi_range(current_difficulty_min, current_difficulty_max)
				print("zero_repit_twice_omegalul")
		spawn_some_platforms(my_random_number)
		delete_unusable_platforms()
		
		Events.difficulty_level = current_difficulty_mode



func spawn_some_platforms(number_of_platforms):
	var array_of_distances = [distant_platform_right,distant_platform_left,distant_platform_middle,distant_nothing]
	biggest_value = array_of_distances.max()
	
	previous_platform = number_of_platforms
	
	if number_of_platforms == 1:
		spawn_noting()
	elif number_of_platforms == 2:
		spawn_platform_left()
	elif number_of_platforms == 3:
		spawn_platform_middle()
	elif number_of_platforms == 4:
		spawn_platform_right()
	elif number_of_platforms == 5:
		spawn_platform_left()
		spawn_platform_middle()
	elif number_of_platforms == 6:
		spawn_platform_middle()
		spawn_platform_right()
	elif number_of_platforms == 7:
		spawn_platform_left()
		spawn_platform_right()
	elif number_of_platforms == 8:
		spawn_platform_left()
		spawn_platform_middle()
		spawn_platform_right()






func spawn_platform_left():
	var barrier_spawn = barrier.instantiate() 
	var platform_instance = platform.instantiate() 
	var spawn_magnet = rng.randi_range(1,20)
	if spawn_magnet < 3:
		platform_instance = magnet.instantiate()
	if spawn_magnet > 3 and spawn_magnet < 6:
		platform_instance = booster.instantiate() 
	add_child(platform_instance)
	
	platform_instance.rotation.z = 0.4
	platform_instance.position.x = 5.7
	platform_instance.position.y = 1.1
	platform_instance.position.z += biggest_value + 45
	distant_platform_left = platform_instance.position.z
	
	
	var spawn_barrier = rng.randi_range(1,40)
	if spawn_barrier < 4 :
		add_child(barrier_spawn)
		barrier_spawn.position.z = biggest_value
		barrier_spawn.position.y = 5
		barrier_spawn.position.x = 5.7
		barrier_spawn.rotation.z = 0.4

	
	
	
	

func spawn_platform_right():
	var barrier_spawn = barrier.instantiate() 
	var platform_instance = platform.instantiate() 
	var spawn_magnet = rng.randi_range(1,20)
	if spawn_magnet < 3:
		platform_instance = magnet.instantiate() 
	if spawn_magnet > 3 and spawn_magnet < 6:
		platform_instance = booster.instantiate() 
	add_child(platform_instance)
	platform_instance.rotation.z = -0.4
	platform_instance.position.x = -5.7
	platform_instance.position.y = 1.1
	platform_instance.position.z += biggest_value + 45
	distant_platform_right = platform_instance.position.z
	
	var spawn_barrier = rng.randi_range(1,40)
	if spawn_barrier < 4 :
		add_child(barrier_spawn)
		barrier_spawn.position.z = biggest_value
		barrier_spawn.position.y = 5
		barrier_spawn.position.x = -5.7
		barrier_spawn.rotation.z = -0.4


func spawn_platform_middle():
	var barrier_spawn = barrier.instantiate() 
	var sonic_spawn = sonic_circle.instantiate()
	var platform_instance = platform.instantiate() 
	var spawn_magnet = rng.randi_range(1,20)
	var distant_platform_height := 0
	
	
	if spawn_magnet < 3:
		platform_instance = magnet.instantiate() 
	if spawn_magnet > 3 and spawn_magnet < 6:
		platform_instance = booster.instantiate() 
	add_child(platform_instance)
	platform_instance.rotation.z = 0
	platform_instance.position.x = 0 
	platform_instance.position.y = 0
	platform_instance.position.z += biggest_value + 45
	distant_platform_middle = platform_instance.position.z
	distant_platform_height = platform_instance.position.y
	
	
	var spawn_sonic = rng.randi_range(1,40)
	var spawn_barrier = rng.randi_range(1,40)
	var spawn_sonic_height = rng.randi_range(8,current_difficulty_mode*7)
	if current_difficulty_mode < 2:
		spawn_sonic_height = rng.randi_range(8,17)
	var spawn_sonic_right_left = rng.randi_range(-5,5)
	if spawn_sonic < current_difficulty_mode*3 :
		add_child(sonic_spawn)
		sonic_spawn.position.z = biggest_value
		sonic_spawn.position.y = distant_platform_height+spawn_sonic_height
		sonic_spawn.position.x = spawn_sonic_right_left
	else:
		if spawn_barrier < 4 :
			add_child(barrier_spawn)
			barrier_spawn.position.z = biggest_value
			barrier_spawn.position.y = distant_platform_height + 5
			barrier_spawn.position.x = 0
	
	
	
	
	
	
	

func spawn_noting():
	distant_nothing = biggest_value

func delete_unusable_platforms():
	var number_of_children = self.get_child_count()
	for child in number_of_children:
		var deleteble_platform = get_child(child)
		if deleteble_platform.position.z + 50 < ball_position:
			deleteble_platform.queue_free
	
	
	
