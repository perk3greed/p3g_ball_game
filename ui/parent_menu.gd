extends Control

var desired_position : Vector2



func _ready():
	pass

func _on_texture_button_pressed():
	var tween = create_tween()
	desired_position.x -= 1600
	tween.tween_property(self, "position", desired_position, 0.5 )


func _on_texture_button_2_pressed():
	var tween = create_tween()
	desired_position.x += 1600
	tween.tween_property(self, "position", desired_position, 0.5 )
