extends RayCast3D

var out_of_bounds :int = 0
var export_bounds :int = 0
var bounds_increaser :int = 0


func _physics_process(delta):
	if is_colliding() == true:
		out_of_bounds = 0
		export_bounds = 0
	else:
		out_of_bounds += delta*200
	
	bounds_increaser = out_of_bounds / 100
	export_bounds = bounds_increaser*out_of_bounds
	Events.bounds_for_style_exported = export_bounds
