extends TextureButton

@export var level_of_button : int

signal button_for_lvls_pressed(level_of_button)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	Events.emit_signal("button_for_lvls_pressed", level_of_button)
#	button_for_lvls_pressed.emit()
