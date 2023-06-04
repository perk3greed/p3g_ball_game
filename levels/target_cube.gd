extends RigidBody3D




func _ready():
	freeze = true
	
	



func _on_body_entered(body):
	freeze = false
	var ball_impulse = (Events.speed_for_export)/2
	var applyed_impulse = Vector3(0, 0, ball_impulse)
	apply_central_impulse(applyed_impulse)
	
