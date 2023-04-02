extends Label
var speed_limit_time : float = 0

func _process(delta):
	
	if Events.speed_for_style_exported > 1:
		self.visible = true
		count_speed_limit_time(delta)
	
	if Events.speed_for_style_exported < 1:
		self.visible = false
		speed_limit_time = 0
	self.text = str("speed limit!  " , str(int(speed_limit_time/100))) 
	
	
	
	
func count_speed_limit_time(delta):
		speed_limit_time += int(100*delta)

	
#var bounds_for_style :int
#var combo_for_style :int
#var part_of_style : float
