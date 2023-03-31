extends Label


func _process(delta):
	self.text = str("style_counter = " , str(Events.style_counter_exported)) 
	
