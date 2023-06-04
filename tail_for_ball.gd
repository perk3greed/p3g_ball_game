extends CSGPolygon3D


func _physics_process(delta):
	var distance = self.position.z - Events.ball_distance_z 
	self.get_material().set_shader_parameter("distance_from_ball",0);
	print(self.position.z)
