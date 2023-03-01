extends Label


func _process(delta):
	if Events.score_rise_to_style != null:
		if Events.score_rise_to_style < 5:
			self.text = str("")
		if Events.score_rise_to_style >5 and Events.score_rise_to_style <10 :
			self.text = str("C")
		if Events.score_rise_to_style >10 and Events.score_rise_to_style <20 :
			self.text = str("B")
		if Events.score_rise_to_style >20 and Events.score_rise_to_style <40 :
			self.text = str("A")
	
