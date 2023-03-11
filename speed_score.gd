extends Label

var speed_for_show = 0
var speed_rise_1 = 0


@onready var main = $"../.."


func _ready():
#	Events.move_speed_to_count.connect(do_the_count_of_score.bind(speed_final))
	main.move_speed_to_count.connect(do_the_count_of_score)


func _process(delta):
	if Events.speed_score_exported != null:
		var exported_stuff = int(Events.speed_score_exported)
		var current_score = 0
		var do_final_score = 0
		speed_for_show += exported_stuff
#		self.text = str("score:" + str(speed_for_show/10))
		self.text = "score: %3d" % [speed_for_show/10]
		Events.score_rise_to_style = speed_rise_1 + exported_stuff

func do_the_count_of_score(speed_final):
	speed_for_show += speed_final
	speed_rise_1 = speed_final
