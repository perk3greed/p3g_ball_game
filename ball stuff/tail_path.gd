extends Path3D

#@export_range(0, 1) var curve_linear_coeff : float = 0.1
#@export_range(1, 200) var curve_contracting_coeff : float = 1.3
@export var length_of_trace : float = 1
var ball_prev_speed : float
@export var prev_delay : float = 1
var scene_time : float = 0
var previous_positions : PackedVector3Array
var ball_position : Vector3
var segments_counter : int = 0
var far_segment_dist : float
var random = RandomNumberGenerator.new()
@export var jittering : float = 0.03
# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	ball_position = get_parent().position
	if scene_time <= prev_delay:
		scene_time += delta
		previous_positions.append(ball_position)
		segments_counter += 1
		curve.add_point(Vector3(0, 0, 0))
	else:
		previous_positions.remove_at(0)
		previous_positions.append(ball_position)
#		far_segment_dist = (previous_positions[0]-ball_position).length()
#		print(ball_position)
#		print(far_segment_dist)
		for i in range(segments_counter):
#			print(i)
#			print(previous_positions[i])
#			print((-ball_position+previous_positions[i])/far_segment_dist*length_of_trace)
			curve.set_point_position(i, (-ball_position+previous_positions[i])*length_of_trace+
			Vector3(random.randf_range(-jittering, jittering),
			random.randf_range(-jittering, jittering),
			random.randf_range(-jittering, jittering)))
#			print()
#			print(curve.get_point_position(i))
#	print(curve.get_point_out(0)) 
#	print(ball_position.normalized()*curve.get_point_position(1).length()*curve_linear_coeff)
#	print()
#	curve.set_point_out(0, ball_position.normalized()*curve_linear_coeff)
#	curve.set_point_position(1, curve.get_point_position(0)+(curve.get_point_position(1)-curve.get_point_position(0))/curve_contracting_coeff)
	
	
	pass
