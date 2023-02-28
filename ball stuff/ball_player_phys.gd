extends RigidBody3D

var speed = 1
var velocity = Vector3.ZERO
var fall_acceleration = 0.01
var times_jumped = 0 
var jump_ready = false
signal out_of_the_bounds
#var speed_for_export = 0 


func _ready():
	pass 

func _process(delta):
	Events.speed_for_export = linear_velocity.z
	if times_jumped == 0:
		jump_ready = true
	else:
		jump_ready = false
	if Input.is_action_pressed("W"):
		apply_central_force(Vector3(0,0,10))
	if Input.is_action_pressed("A"):
		apply_central_force(Vector3(5,0,0))
	if Input.is_action_pressed("S"):
		apply_central_force(Vector3(0,0,-5))
	if Input.is_action_pressed("D"):
		apply_central_force(Vector3(-5,0,0))
	if Input.is_action_just_pressed("ui_accept") and jump_ready:
		apply_central_force(Vector3(0,300,0))
		times_jumped += 1 



func _on_body_entered(body):
	times_jumped = 0
	if body.is_in_group("out_of_bounds"):
		print("BTUHF")
		Events.emit_signal("out_of_the_bounds")
	if body.get_parent().is_in_group("out_of_bounds"):
		print("fsfsfsf")
		Events.emit_signal("out_of_the_bounds")

