#makes camera follow ball

extends Node
var startCam
var startBall


func _ready():
	startCam = $Camera3D.position
	startBall = $RigidBody3D.position
	pass # Replace with function body.


func _process(delta):
	$Camera3D.position = startCam + ($RigidBody3D.position - startBall)
