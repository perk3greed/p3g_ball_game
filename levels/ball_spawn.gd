extends Node3D



func _ready():
	var my_place_in_this_world = self.position
	Levels.spawn_points = my_place_in_this_world
#	var my spot_in_this_world = self.position
