extends Label


func _process(delta):
	self.text = str("style_counter = " , str(Events.style_counter_exported)) 
	
#
#	 "style_counter_additive = " , str(Events.style_counter_additive_exported) \ "airtime = " , str(Events.airtime_exported))



#
#var airtime :int 
#var speed_for_style :int
#var bounds_for_style :int
#var combo_for_style :int
#var part_of_style : float
