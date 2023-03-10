extends RigidBody3D

var times_jumped = 0 
var jump_ready = false
signal out_of_the_bounds
var camera_normal : Vector3 = Vector3.ZERO
var Mat : ShaderMaterial
var current_color : Vector3 = Vector3(0, 0.2, 0.5)
var prev_color : Vector3 = Vector3(0, 0.2, 0.5)
var rank : int = 0
var prev_rank : int = 0
var interp_coeff : float = 0

@export var color_norank : Color = Color(0, 0.16, 0.43)
@export var color_C : Color = Color(0, 0.84, 0.69)
@export var color_B : Color = Color(0.93, 0.01, 0)
@export var color_A : Color = Color(1, 0.85, 0)
#var vector_norank : Vector3
#var vector_C : Vector3
#var vector_B : Vector3
#var vector_A : Vector3
var color_dict : Array

func color_to_vector_rgb(color_input: Color) -> Vector3:
	return Vector3(color_input.r, color_input.g, color_input.b)

func _ready():
	Events.connect("ball_is_out_of_bounds", restart_position)
	Mat = get_node("CSGSphere3D").get_material()
	
	color_dict = [
		color_to_vector_rgb(color_norank),
		color_to_vector_rgb(color_C),
		color_to_vector_rgb(color_B),
		color_to_vector_rgb(color_A) ]

func _process(delta):
	if prev_rank != rank: # rank was changed
		interp_coeff = 0
		prev_color = current_color
	if interp_coeff < 1: # lerp from prev color to new with X seconds (delta/X)
		interp_coeff += delta/0.1
		current_color = prev_color.lerp(color_dict[rank], interp_coeff)
	Mat.set_shader_parameter("colour", current_color)
	Events.rotations_for_camera = linear_velocity.x
	Events.speed_for_export = linear_velocity.z
	if times_jumped == 0:
		jump_ready = true
	else:
		jump_ready = false
	if Input.is_action_pressed("W"):
		apply_central_force(-camera_normal*10)
	if Input.is_action_pressed("A"):
		apply_central_force(Vector3(5,0,0))
	if Input.is_action_pressed("S"):
		apply_central_force(Vector3(0,0,-5))
	if Input.is_action_pressed("D"):
		apply_central_force(Vector3(-5,0,0))
	if Input.is_action_just_pressed("ui_accept") and jump_ready:
		apply_central_force(Vector3(0,300,0))
		times_jumped += 1 
	
	
#	Events.positions = str(int(self.position.x)) + "___"+ str(int(self.position.y)) + "___" + str(int(self.position.z)) 
	Events.positions = "%d___%d___%d" % [position.x, position.y, position.z]
	
	if Events.score_rise_to_style != null:
		if Events.score_rise_to_style < 5:
			rank = 0
		if Events.score_rise_to_style >5 and Events.score_rise_to_style <10 :
			rank = 1
		if Events.score_rise_to_style >10 and Events.score_rise_to_style <20 :
			rank = 2
		if Events.score_rise_to_style >20 and Events.score_rise_to_style <40 :
			rank = 3

func _on_body_entered(body):
	times_jumped = 0
	if body.is_in_group("out_of_bounds"):
		Events.emit_signal("out_of_the_bounds")
	if body.get_parent().is_in_group("out_of_bounds"):
		Events.emit_signal("out_of_the_bounds")

func restart_position():
	var current_level = Levels.current_level_is
	self.position = Vector3.ZERO
	self.look_at(Vector3(0,0,1))
#	 Levels.spawn_points_for_ball[current_level]
#	you can do checkpoits like this with origins))
	self.freeze = true
	await get_tree().create_timer(0.5).timeout
	self.freeze = false

func current_camera_normal_import(get_data):
	camera_normal = get_data
