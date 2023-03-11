extends Label


func _process(delta):
	if Events.score_rise_to_style != null:
		if Events.score_rise_to_style < 5:
			self.text = "\nz-speed: %3.2f\ncapped lol" % Events.speed_for_export
		if Events.score_rise_to_style >5 and Events.score_rise_to_style <10 :
			self.text = "C\nz-speed: %3.2f\ncapped lol" % Events.speed_for_export
		if Events.score_rise_to_style >10 and Events.score_rise_to_style <20 :
			self.text = "B\nz-speed: %3.2f\ncapped lol" % Events.speed_for_export
		if Events.score_rise_to_style >20 and Events.score_rise_to_style <40 :
			self.text = "A\nz-speed: %3.2f\ncapped lol" % Events.speed_for_export
	
