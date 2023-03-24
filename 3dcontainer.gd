extends Node3D



func _ready():
	Events.connect("ball_is_out_of_bounds", restart_position) 
#	var ball_instance = load("res://ball stuff/ball_node.tscn").instantiate()

func restart_position():
	var ball_instance = load("res://ball stuff/ball_node.tscn").instantiate()
#	var ball_instance = load("res://ball stuff/new_player.tscn").instantiate()
	print("i_Should_add_a_child")
	self.add_child(ball_instance)

func load_lvl(level_of_button):
#	var ball_instance = load("res://ball stuff/new_player.tscn").instantiate()
	var ball_instance = load("res://ball stuff/ball_node.tscn").instantiate()
	Levels.current_level_that_is_set = level_of_button
	var level_to_instance = str(Levels.level_variations[level_of_button])
	var level_instanced = load(level_to_instance).instantiate()
	self.add_child(level_instanced)
	self.add_child(ball_instance)
	return ball_instance
