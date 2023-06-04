extends Area3D

signal sky_exited
signal sky_entered

func _on_body_entered(body):
	Events.emit_signal("sky_entered")

func _on_body_exited(body):
	Events.emit_signal("sky_exited")
