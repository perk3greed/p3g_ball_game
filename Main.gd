extends Node

signal move_speed_to_count(speed_final)
signal ball_is_out_of_bounds

@onready var container3d = get_node("3dcontainer")


var speed_score = 0 

func _ready():
	Events.connect("button_for_lvls_pressed", do_lvl_change)
	Events.connect("out_of_the_bounds", do_menu_visible)

func _process(delta):
#	if Events.speed_for_export != null:
#		var speed_convert = Events.speed_for_export
#		if speed_convert >10:
#			speed_score += int(speed_convert/10)
#		if speed_convert <10:
#			Events.speed_counted_score = speed_score
###			Events.emit_signal("move_speed_to_count",speed_score )
#			self.emit_signal("move_speed_to_count", speed_score)
#			speed_score = 0
#		Events.speed_score_exported = speed_score/10
	if Input.is_action_just_pressed("R"):
		self.do_lvl_change(Levels.current_level_that_is_set)
		Events.current_most_distant_cube = 0
		Events.emit_signal("ball_is_out_of_bounds")

func do_menu_visible():
	get_node("Control/menu").visible = true




func do_lvl_change(level_of_button):
	Settings.camera_rotation_x = 0
	var childs = container3d.get_children()
	var container3dsize = childs.size()
	for i in container3dsize:
		var current_child = childs[i]
		current_child.queue_free()
	
	get_node("Control/menu").visible = false
	container3d.load_lvl(level_of_button)
#	get_node("Control/menu").visible = false


func _on_texture_button_pressed():
	get_node("Control/menu").visible = true
