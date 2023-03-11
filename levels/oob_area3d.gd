extends Area3D

signal ball_is_out_of_bounds



func _on_body_entered(body):
	Events.emit_signal("ball_is_out_of_bounds")
