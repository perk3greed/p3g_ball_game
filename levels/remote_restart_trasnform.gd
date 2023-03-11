extends RemoteTransform3D



func _ready():
	Events.connect("ball_is_out_of_bounds", restart_ball_pos)
#	update_position = false
#	update_rotation = false
#	update_scale = false
	

func _process(delta):
	pass


func restart_ball_pos():
	self.position.z = -80
	self.position.y = 200
	update_position = true
	update_rotation = true
