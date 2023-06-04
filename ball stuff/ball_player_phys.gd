extends RigidBody3D


var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN


var times_jumped = 0 
var jump_ready = false
signal out_of_the_bounds
var camera_normal : Vector3 = Vector3.ZERO
var Mat : ShaderMaterial
var PartMat : ShaderMaterial
var current_color : Vector3 = Vector3(0, 0.2, 0.5)
var prev_color : Vector3 = Vector3(0, 0.2, 0.5)
var rank : int = 0
var prev_rank : int = 0
var interp_coeff : float = 0
var score
var look_vector = Vector3(1,1,1)
var current_accelereation_mode :int
var current_difficulty_level :int
var current_jump_level :int
var max_permitted_speed :int
var damp_from_difficulty :int
var style :float 
var style_counter :String 
var style_counter_additive :int
var airtime :int 
var speed_for_style :int
var bounds_for_style :int 
var combo_for_style :int
var part_of_additive : float
var part_of_additive_flat :float
var previous_style :float = 0
var style_delta :float = 0
var sky_damp :bool = false
var magnet_stylish :int = 0
var boost_stylish :int = 0
var counter_additive_real :int = 0
var style_counter_additive_v2 :int = 0
var airtime_multi :int = 0
var airtime_additive :int = 0
var animation_vector :Vector3 = Vector3(1, 1, 1)
var jump_occured :bool = false
var highest_jump :float = 0
var cycle_count : int = 1

var OLDMAX = 50
var OLDMIN = 1
var NEWMAX = 0.9
var NEWMIN = 0.01
var old : float 
var new : float
var jump_fall_damage : float
var boost_is_working : bool = false

@export var color_norank : Color = Color(0, 0.16, 0.43)
@export var color_C : Color = Color(0, 0.84, 0.69)
@export var color_B : Color = Color(0.93, 0.01, 0)
@export var color_A : Color = Color(1, 0.85, 0)

@export var speed_norank : float = 4
@export var speed_C : float = 9
@export var speed_B : float = 18

@export var speed_nowind : float = 10
@export var speed_wind : float = 40
@export var wind_opacity : float = 0.4

var color_dict : Array

func color_to_vector_rgb(color_input: Color) -> Vector3:
	return Vector3(color_input.r, color_input.g, color_input.b)

func _ready():

	Events.connect("sky_entered", do_sky_damp)
	Events.connect("sky_exited", finish_sky_damp)
	Events.connect("sonic_entered", do_a_boost)
	Events.connect("ball_is_out_of_bounds", restart_position)
	
	Mat = get_node("CSGSphere3D").get_material()
	PartMat = $wind_particles.mesh.get_material()
	
	self.position = Vector3(0, 10, 0)
	$SpringArm3D/Camera3D.make_current()
	
	$SpringArm3D.rotate_x(0.2)
	
	color_dict = [
		color_to_vector_rgb(color_norank),
		color_to_vector_rgb(color_C),
		color_to_vector_rgb(color_B),
		color_to_vector_rgb(color_A) ]



func _process(delta):
	
	
	var global_ball_place = self.global_position
	var raycast_hit_position = $RayCast3D.get_collision_point()
	var jump_height = global_ball_place.y - raycast_hit_position.y
	if jump_height > highest_jump:
		highest_jump = jump_height
	if highest_jump > 1:
		jump_occured = true
	
#	print(animation_vector.y)
	
#	do_style_counter_v2()
	
			#style counter part
	style_counter_additive += bounds_for_style
	style_counter_additive += airtime_additive
	style_counter_additive += int(speed_for_style*delta*50)
#	print(speed_for_style*delta)


	style_counter_additive -= int(1)
	part_of_additive_flat = style_counter_additive/100
	part_of_additive = style_counter_additive/30
	style_counter_additive -= int(part_of_additive*delta)
	style_counter_additive -= int(part_of_additive_flat)
#	print(style_counter_additive)
	if style_counter_additive > 16000 :
		style_counter_additive = 16000
#
	
	if style_counter_additive < 1:
		style_counter_additive = 0
	
	style += int(style_counter_additive*delta/15)
	
	
	if style_counter_additive <= 120:
		style_counter = "" 
		damp_from_difficulty = 1.1
	
	if style_counter_additive > 250:
		style_counter = "C" 
		damp_from_difficulty = 1.0
		
	if style_counter_additive > 700:
		style_counter = "B"
		damp_from_difficulty = 0.9
	
	if style_counter_additive > 1000:
		style_counter = "A"
		damp_from_difficulty = 0.8
	
	if style_counter_additive > 3000:
		style_counter = "S"
		damp_from_difficulty = 0.7
	
	if style_counter_additive > 8000:
		style_counter = "SS"
		damp_from_difficulty = 0.6
	
	if style_counter_additive > 15000:
		style_counter = "SSS"
		damp_from_difficulty = 0.5
	
	set_style_additive(style_counter_additive_v2)
	counter_additive_real = 0
	style_counter_additive_v2 = 0
	
	
	Events.style_exported = style
	Events.style_counter_exported = style_counter
	Events.style_counter_additive_exported = style_counter_additive
	Events.airtime_exported = airtime
	Events.speed_for_style_exported = speed_for_style
	bounds_for_style = Events.bounds_for_style_exported
	Events.combo_for_style_exported = combo_for_style
	Events.part_of_style_exported = part_of_additive
	
	if linear_velocity.z > (max_permitted_speed - max_permitted_speed*1.5):
		speed_for_style = int((linear_velocity.z)*10)
	if linear_velocity.z < (max_permitted_speed - max_permitted_speed/100.0) :
		speed_for_style = 0
	
	airtime += 100*delta
	
	airtime_multi = airtime/100 
	
	airtime_additive = airtime_multi*airtime
	
			#camera control part
	var move_direction := Vector3.ZERO
	
	if $SpringArm3D/Camera3D.fov < 120:
		if linear_velocity.x + linear_velocity.y + linear_velocity.z > 7: 
			$SpringArm3D/Camera3D.fov += 10*delta
	if $SpringArm3D/Camera3D.fov > 90:
		if linear_velocity.x + linear_velocity.y + linear_velocity.z < 7:
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
	
#	print(boost_is_working)
	
	if boost_is_working == true :
		
		animation_vector.z += delta*(cycle_count/60)
		
		cycle_count += 1
		if cycle_count > 240:
			cycle_count = 1
			boost_is_working = false
	
	
	
	if sky_damp == true:
		animation_vector.z -= delta*0.1
		animation_vector.x += delta*0.2
	
	
	if animation_vector.x > 1:
		animation_vector.x -= delta*(animation_vector.x - 1)
	if animation_vector.x < 1:
		animation_vector.x += delta*(1-animation_vector.x)
	
	if animation_vector.y > 1:
		animation_vector.y -= delta*(animation_vector.y - 1)*2
	if animation_vector.y < 1:
		animation_vector.y += delta*(1-animation_vector.y)*3
	
	if animation_vector.z > 1:
		animation_vector.z -= delta*(animation_vector.z - 1)
	if animation_vector.z < 1:
		animation_vector.z += delta*(1-animation_vector.z)
	
	
	$CSGSphere3D.scale = animation_vector
	
	$wind_particles.rotation = Vector3(PI+linear_velocity.normalized().angle_to(Vector3(0, 1, 0)), 0, 0)
	if linear_velocity.length() <= speed_nowind:
		PartMat.set_shader_parameter("opacity", 0)
	elif linear_velocity.length() <= speed_wind:
		PartMat.set_shader_parameter("opacity", (linear_velocity.length()-speed_nowind)/(speed_wind-speed_nowind)*wind_opacity)
	else:
		PartMat.set_shader_parameter("opacity", wind_opacity)
	
	if sky_damp:
		if animation_vector.z > 0.8 :
			animation_vector.z -= delta*0.1
		apply_central_force(Vector3(0,0,-5))
	
	
	if linear_velocity.z < 0:
		linear_velocity.z = 0
	
	
	
	if times_jumped < 2:
		jump_ready = true
	else:
		jump_ready = false
	
	if linear_velocity.z < 32:
		current_jump_level = 8
	else :
		current_jump_level = linear_velocity.z/4
		
#	max_permitted_speed = style/500
	
	current_difficulty_level = Events.difficulty_level
	if current_difficulty_level == 0:
		current_accelereation_mode = 10
		
	if current_difficulty_level == 1:
		current_accelereation_mode = 8
		max_permitted_speed = 35
	
	if current_difficulty_level == 2:
		current_accelereation_mode = 6
		max_permitted_speed = 60
	
	if current_difficulty_level == 3:
		current_accelereation_mode = 4
		max_permitted_speed = 110
	
	if current_difficulty_level == 4:
		current_accelereation_mode = 3
		max_permitted_speed = 150
	
	
	
	var look_direction = $SpringArm3D.global_rotation
	var movement_vector = 0
	look_vector = -$SpringArm3D/Camera3D.global_transform.basis.z
	
#	if Input.is_action_pressed("W"):
	movement_vector = look_vector.normalized()
	movement_vector.y = 0
	apply_central_impulse(self.basis.z.normalized()/16)

	if Input.is_action_pressed("A"):
		if Setload.bouncy_mode == true:
			apply_central_impulse(self.basis.x.normalized()/3)
		else:
			apply_central_impulse(self.basis.x.normalized()/6)
		
	
	if Input.is_action_pressed("S"):
		look_vector = $SpringArm3D/Camera3D.global_transform.basis.z
		movement_vector = look_vector.normalized()
		movement_vector.y = 0
		apply_central_impulse(movement_vector/3)

	if Input.is_action_pressed("D"):
		if Setload.bouncy_mode == true:
			apply_central_impulse(-self.basis.x.normalized()/3)
		else:
			apply_central_impulse(-self.basis.x.normalized()/6)



	if Input.is_action_just_pressed("ui_accept") and jump_ready:
		boost_is_working = false
		highest_jump = 0
		
		for i in range(15):
			animation_vector.y += (1+((100/(i+1))/10))*delta*current_jump_level/35
#			print(delta)
		
		
		apply_central_impulse(Vector3(0,current_jump_level,0))
		times_jumped += 1 
		
	if linear_velocity.z > max_permitted_speed  and linear_damp < damp_from_difficulty:
		linear_damp += 0.2*delta
	
	if linear_velocity.z < max_permitted_speed and linear_damp > damp_from_difficulty:
		linear_damp -= 0.4*delta
	


func _on_body_entered(body):
	
	
	
	
	
	if Setload.bouncy_mode == true:
		apply_central_impulse(Vector3(0,current_jump_level,3))
		times_jumped = 2
	
#	apply_central_impulse(Vector3(0,current_jump_level,0))
	
	airtime = 0
	if Setload.bouncy_mode == false : 
		times_jumped = 0
	
	if jump_occured == true:
		if highest_jump > 50:
			highest_jump = 50
		old = highest_jump
		new = (old - OLDMIN)/(OLDMAX-OLDMIN)*(exp(NEWMAX-NEWMIN) - 1) + 1
		jump_fall_damage = log(new) + NEWMIN
		for g in range(20):
#			print(jump_fall_damage)
			animation_vector.y -= 0.01666*( jump_fall_damage*3)
		
		$collision_spark.amount = new*10 - 2
		$collision_spark.emitting = true
	
#		animation_vector.y -= 0.2
		jump_occured = false
		highest_jump = 0
		
	
	
	if body.is_in_group("normal panel"):

		boost_is_working = false
		combo_for_style = 0
		counter_additive_real = 0
		style_counter_additive_v2 = 0
		do_counter_addition_boosts(counter_additive_real)
#		style_counter_additive= 0
	if body.is_in_group("out_of_bounds"):
		Events.emit_signal("out_of_the_bounds")
	if body.get_parent().is_in_group("out_of_bounds"):
		Events.emit_signal("out_of_the_bounds")
	if body.is_in_group("finish_group"):
		Events.emit_signal("out_of_the_bounds")
	if body.is_in_group("cube_group"):
		Events.emit_signal("bounced_cube", body)
	
	
	if body.is_in_group("magnet"):
		apply_central_impulse(Vector3(0,current_jump_level,3))
		
		

		for i in range(15):
			animation_vector.y += (1+((75/(i+1))/10))*0.01666*current_jump_level/10

		
		
		combo_for_style += 1
		counter_additive_real = combo_for_style*50
		do_counter_addition_boosts(counter_additive_real)
	
	
	
	
	if body.is_in_group("boost"):
		if Setload.bouncy_mode == false :
			boost_is_working = true
		
		apply_central_impulse(Vector3(0,-6.84,18.8))
		combo_for_style += 1
		
		counter_additive_real += combo_for_style*50
		do_counter_addition_boosts(counter_additive_real)
		
#
#	if body.is_in_group("barrier"):
#		print("barrier_hit")
#		apply_central_impulse(Vector3(0,0,-5))
#
#		for i in range(20):
#			animation_vector.z -= 0.01666*200
#			animation_vector.x += 1
		
	
func  do_counter_addition_boosts(counter_additive_real):
	style_counter_additive_v2 += counter_additive_real
	set_style_additive(style_counter_additive_v2)

func set_style_additive(style_counter_additive_v2):
#	print(style_counter_additive_v2)
	style_counter_additive += style_counter_additive_v2
	style_counter_additive_v2 = 0


func do_a_boost():
	apply_central_impulse(Vector3(0,5,17)) 
	times_jumped = 0
	combo_for_style += 1
	style_counter_additive += combo_for_style*500

func restart_position():
	$SpringArm3D/Camera3D.clear_current()
	self.queue_free()

func do_sky_damp():
	
	print("sky entered")
	sky_damp = true
	
	
func finish_sky_damp():
	print("sky exited")
	sky_damp = false















