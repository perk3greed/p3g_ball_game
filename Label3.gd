extends Label


func _process(delta):
	if Events.airtime_exported > 199:
		self.visible = true
	if Events.airtime_exported < 199:
		self.visible = false
	
	self.text = str("airtime! " , str(Events.airtime_exported/100)) 
	
	
	
#var speed_for_style :int
#var bounds_for_style :int
#var combo_for_style :int
#var part_of_style : float
