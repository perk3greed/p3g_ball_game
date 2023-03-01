#makes camera follow ball

extends Node
var startCam
var startBall


func _ready():
	Events.connect("ball_is_out_of_bounds", restart_position) 
	var current_level = Levels.current_level_is
	self.position = Levels.spawn_points_for_ball[current_level]
	startCam = $Camera3D.position
	startBall = $RigidBody3D.position
	$Camera3D.current = true

func restart_position():
#	self.queue_free()
#	$Camera3D.current = false
	pass



func _process(delta):
	$Camera3D.position = startCam + ($RigidBody3D.position - startBall)
