extends Label

var bound_time : float = 0 

func _process(delta):
	if Events.bounds_for_style_exported > 1:
		bound_time += delta*100
		self.visible = true
	if Events.bounds_for_style_exported < 1:
		bound_time = 0
		self.visible = false
	self.text = str("out of bounds! " , str(int(bound_time))) 
	
	
#var combo_for_style :int
#var part_of_style : float
