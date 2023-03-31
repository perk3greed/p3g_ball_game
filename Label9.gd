extends Label


func _process(delta):
	self.text = str("current_speed = " , str(int(Events.speed_for_export))) 
	
