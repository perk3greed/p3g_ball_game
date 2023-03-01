extends RigidBody3D

var times_jumped = 0 
var jump_ready = false
signal out_of_the_bounds



func _ready():
	Events.connect("ball_is_out_of_bounds", restart_position) 

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
	
	
	Events.positions = str(int(self.position.x)) + "___"+ str(int(self.position.y)) + "___" + str(int(self.position.z)) 


func _on_body_entered(body):
	times_jumped = 0
	if body.is_in_group("out_of_bounds"):
		Events.emit_signal("out_of_the_bounds")
	if body.get_parent().is_in_group("out_of_bounds"):
		Events.emit_signal("out_of_the_bounds")

func restart_position():
	var current_level = Levels.current_level_is
	self.position = Vector3.ZERO
#	 Levels.spawn_points_for_ball[current_level]
#	you can do checkpoits like this with origins))
	self.freeze = true
	await get_tree().create_timer(0.5).timeout
	self.freeze = false

	
