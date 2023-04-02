extends Label


func _process(_delta):
	if Events.combo_for_style_exported > 0:
		self.visible = true
	if Events.combo_for_style_exported < 1:
		self.visible = false
		
	self.text = str("combo!" , str(Events.combo_for_style_exported)) 
	
	
#var part_of_style : float
