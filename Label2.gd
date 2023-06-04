extends Label


func _process(delta):
	self.text = str("panel = " , str(Events.biggest_value_exported)) 
	
	
	
#	 \ "airtime = " , str(Events.airtime_exported))



#
#var airtime :int 
#var speed_for_style :int
#var bounds_for_style :int
#var combo_for_style :int
#var part_of_style : float
