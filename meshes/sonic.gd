extends Area3D


signal sonic_entered



func _on_body_entered(body):
	if body.is_class("RigidBody3D"):
		Events.emit_signal("sonic_entered")
