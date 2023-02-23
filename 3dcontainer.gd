extends Node3D



func _ready():
	var levelNode = preload("res://levels/level_0-b.tscn").instantiate()
	self.add_child(levelNode)
	var ballNode = preload("res://ball stuff/ball_node.tscn").instantiate()
	ballNode.position = Vector3(0, 9.106, -10.903)
	self.add_child(ballNode)
