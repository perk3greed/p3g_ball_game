extends Node3D

#var current_level = 1

func _ready():
	pass
#	var level1 = preload("res://levels/level_0-b.tscn").instantiate()
#	self.add_child(level1)
#	var ballNode = preload("res://ball stuff/ball_node.tscn").instantiate()
#	ballNode.position = Vector3(0, 9.106, -10.903)
#	self.add_child(ballNode)






func load_lvl(level_of_button):
	var level_to_instance = str(Levels.level_variations[level_of_button])
	var level_instanced = load(level_to_instance).instantiate()
	self.add_child(level_instanced)
