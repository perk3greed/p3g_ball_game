extends Node3D

signal set_camera

func _ready():
	Settings.camera_rotation_x = 0.2
	print("i shold signal camer")
	Events.emit_signal("set_camera")
