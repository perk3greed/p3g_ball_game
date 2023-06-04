extends CheckBox




func _on_toggled(button_pressed):
	if button_pressed == true:
		Setload.bouncy_mode = true
	if button_pressed == false:
		Setload.bouncy_mode = false
