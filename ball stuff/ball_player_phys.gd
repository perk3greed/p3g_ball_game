extends RigidBody3D


var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN


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
var score
var look_vector = Vector3(1,1,1)

@export var color_norank : Color = Color(0, 0.16, 0.43)
@export var color_C : Color = Color(0, 0.84, 0.69)
@export var color_B : Color = Color(0.93, 0.01, 0)
@export var color_A : Color = Color(1, 0.85, 0)

@export var speed_norank : float = 4
@export var speed_C : float = 9
@export var speed_B : float = 18

var color_dict : Array

func color_to_vector_rgb(color_input: Color) -> Vector3:
	return Vector3(color_input.r, color_input.g, color_input.b)

func _ready():
	Events.connect("ball_is_out_of_bounds", restart_position)
	Mat = get_node("CSGSphere3D").get_material()
	
	self.position = Vector3(0, 10, 0)
	$SpringArm3D/Camera3D.make_current()
	
	$SpringArm3D.rotate_x(0.2)
	
	
	
	
	color_dict = [
		color_to_vector_rgb(color_norank),
		color_to_vector_rgb(color_C),
		color_to_vector_rgb(color_B),
		color_to_vector_rgb(color_A) ]

func _process(delta):
	print(delta)
	var move_direction := Vector3.ZERO
	
	if $SpringArm3D/Camera3D.fov < 120:
		if linear_velocity.x + linear_velocity.y + linear_velocity.z > 15: 
			$SpringArm3D/Camera3D.fov += 10*delta
	if $SpringArm3D/Camera3D.fov > 90:
		if linear_velocity.x + linear_velocity.y + linear_velocity.z < 15:
			$SpringArm3D/Camera3D.fov -= 10*delta
#
	Mat.set_shader_parameter("colour", current_color)
	Events.rotations_for_camera = _velocity.x
	Events.speed_for_export = linear_velocity.z

	
	
	Events.ball_distance_z = self.position.z
	Events.positions = "%d___%d___%d" % [position.x, position.y, position.z]
	score = linear_velocity.z
	if score != null:
		if score < speed_norank:
			rank = 0
			current_color = color_dict[rank].lerp(color_dict[rank+1], score/speed_norank)
		if score >= speed_norank and score < speed_C:
			rank = 1
			current_color = color_dict[rank].lerp(color_dict[rank+1], (score-speed_norank)/(speed_C-speed_norank))
		if score >= speed_C and score < speed_B:
			rank = 2
			current_color = color_dict[rank].lerp(color_dict[rank+1], (score-speed_C)/(speed_B-speed_C))
		if score >= speed_B:
			rank = 3
			current_color = color_dict[rank]


func _physics_process(delta):
		
	if times_jumped < 2:
		jump_ready = true
	else:
		jump_ready = false
	
	var look_direction = $SpringArm3D.global_rotation
	var movement_vector = 0
	look_vector = -$SpringArm3D/Camera3D.global_transform.basis.z
	
	if Input.is_action_pressed("W"):
		movement_vector = look_vector.normalized()
		movement_vector.y = 0
		apply_central_impulse(self.basis.z.normalized()/4)
	if Input.is_action_pressed("A"):
		
		apply_central_impulse(self.basis.x.normalized()/4)
		
		
#		rotate_y(lerp_angle(0 , 0.1, delta*15 ))
	if Input.is_action_pressed("S"):
		look_vector = $SpringArm3D/Camera3D.global_transform.basis.z
		movement_vector = look_vector.normalized()
		movement_vector.y = 0
		apply_central_impulse(movement_vector/4)
	if Input.is_action_pressed("D"):
		
		apply_central_impulse(-self.basis.x.normalized()/4)
		
#		rotate_y(lerp_angle(0 , -0.1, delta*15 ))
	if Input.is_action_just_pressed("ui_accept") and jump_ready:
		apply_central_impulse(Vector3(0,8,0))
		times_jumped += 1 
		
	
	
	if linear_velocity.z > 10 and linear_damp < 0.31:
		linear_damp += 0.05*delta
	
	if linear_velocity.z < 10 and linear_damp > 0.3:
		linear_damp -= 0.4*delta
	
	
	
	

func _on_body_entered(body):
	times_jumped = 0
	if body.is_in_group("out_of_bounds"):
		Events.emit_signal("out_of_the_bounds")
	if body.get_parent().is_in_group("out_of_bounds"):
		Events.emit_signal("out_of_the_bounds")
	if body.is_in_group("finish_group"):
		Events.emit_signal("out_of_the_bounds")


func restart_position():
	$SpringArm3D/Camera3D.clear_current()
#	await get_tree().create_timer(0.1ц).timeout
	self.queue_free()
