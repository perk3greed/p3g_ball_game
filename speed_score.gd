extends Label


func _process(delta):
	self.text = str(int(Events.style_exported))

