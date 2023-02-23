extends Node

signal move_speed_to_count(speed_final)

#@onready var container3d = get_node("3dcontainer")

var speed_score = 0 

func _ready():
	pass
#	var meta3dnode = preload("res://meta_3d.tscn").instantiate()
#	container3d.add_child(meta3dnode)

func _process(delta):
	if Events.speed_for_export != null:
		var speed_convert = Events.speed_for_export
		if speed_convert >10:
			speed_score += int(speed_convert/10)
		if speed_convert <10:
			Events.speed_counted_score = speed_score
#			Events.emit_signal("move_speed_to_count",speed_score )
			self.emit_signal("move_speed_to_count", speed_score)
			speed_score = 0
		Events.speed_score_exported = speed_score/10
