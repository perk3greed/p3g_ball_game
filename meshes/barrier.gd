extends Area3D


func _on_body_entered(body):
	var linear_slowdown := 0
	if body.is_in_group("player"):
		if body.linear_velocity.z < 35:
			linear_slowdown = body.linear_velocity.z*0.8
		else:
			linear_slowdown = 28
		body.apply_central_impulse(Vector3(0,0,-linear_slowdown))
	
