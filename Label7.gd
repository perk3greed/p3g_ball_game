extends Label


func _process(delta):
	self.text = str("part_of_style = " , str(Events.part_of_style_exported)) 
	
	
#var part_of_style : float