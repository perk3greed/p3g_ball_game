extends TextureButton

@export var level_of_button : int

signal button_for_lvls_pressed(level_of_button)

func _on_pressed():
	Events.emit_signal("button_for_lvls_pressed", level_of_button)
