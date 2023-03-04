#makes camera follow ball

extends Node
var startCam
var startBall

#@onready var camera_for_ball = get_node("Camera3D")

func _ready():
	Events.connect("ball_is_out_of_bounds", restart_position) 
	var current_level = Levels.current_level_is
	self.position = Levels.spawn_points_for_ball[current_level]
	startCam = $Camera3D.position
	startBall = $RigidBody3D.position
	$Camera3D.make_current()
	

func restart_position():
	$Camera3D.clear_current()
	await get_tree().create_timer(0.5).timeout
	self.queue_free()


func _process(delta):
	var rotate_z = Events.speed_for_export
	var rotate_y = Events.rotations_for_camera
	$Camera3D.position = startCam + ($RigidBody3D.position - startBall)
	if rotate_y != null:
		$Camera3D.rotate_y((rotate_y)*delta/50)
	if rotate_z != null:
		$Camera3D.rotate_x((rotate_z)*delta/300)
		if rotate_z > 10 and $Camera3D.fov <120:
			$Camera3D.fov += 10*delta
		if rotate_z < 10 and $Camera3D.fov > 90:
			$Camera3D.fov -= 10*delta
