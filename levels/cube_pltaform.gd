extends StaticBody3D

var b_number : int = 0
var shader_changing : bool = false
var which_cube_name : String
var which_cube_id : int
@export var animation_time : float = 1
@export var animation_subtlety : Vector3 = Vector3(20, 4, 20)
# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("bounced_cube", _on_bounce)
	get_parent().get_material().set_shader_parameter("unique_id", self.get_instance_id())
	get_parent().get_material().set_shader_parameter("current_id", 0)
	print(get_parent().get_material().get_shader_parameter("unique_id"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var local_timer : float = 0
func _process(delta):
	if shader_changing:
		print("we're changing shader of ", self.get_instance_id())
		print("we should change only ", which_cube_id)
		get_parent().get_material().set_shader_parameter("current_id", which_cube_id)
		if local_timer <= PI:
			print(local_timer)
			get_parent().get_material().set_shader_parameter(
				"cube_3d_scale",
				Vector3(
					1+sin(local_timer*4)/animation_subtlety.x,
					1-sin(local_timer*4)/animation_subtlety.y,
					1+sin(local_timer*4)/animation_subtlety.z
					)
				)
			print("current_id of shader ", get_parent().get_material().get_shader_parameter("current_id"))
			print("unique_id of shader ", get_parent().get_material().get_shader_parameter("unique_id"))
			local_timer += PI*delta/animation_time
		else:
			shader_changing = false
			local_timer = 0.0
			get_parent().get_material().set_shader_parameter(
				"cube_3d_scale",
				Vector3(1, 1, 1)
				)
			print("we've stopped changing shader")
	pass

func _on_bounce(which_cube : StaticBody3D):
	print(which_cube)
	if which_cube == self:
		b_number += 1
		print("this is cube ", self, " speaking")
		print("bounce number ", b_number)
		shader_changing = true
	which_cube_id = which_cube.get_instance_id()
