extends LineEdit

@export var what_setting : String
@export var defolt_setting : int 

func _ready():
	if what_setting == "difficulty1":
		Setload.difficulty_setting_array["count_barrier_difficulty_1"] = defolt_setting
		print(defolt_setting)
	elif what_setting == "difficulty2":
		Setload.difficulty_setting_array["count_barrier_difficulty_2"] = defolt_setting
		print(defolt_setting)
	elif what_setting == "difficulty3":
		Setload.difficulty_setting_array["count_barrier_difficulty_3"] = defolt_setting
		print(defolt_setting)
	elif what_setting == "difficulty4":
		Setload.difficulty_setting_array["count_barrier_difficulty_4"] = defolt_setting
		print(defolt_setting)
	
	
	

func _on_text_submitted(new_text):
	
	if what_setting == "difficulty1":
		Setload.difficulty_setting_array["count_barrier_difficulty_1"] = int(new_text)
	elif what_setting == "difficulty2":
		Setload.difficulty_setting_array["count_barrier_difficulty_2"] = int(new_text)
	elif what_setting == "difficulty3":
		Setload.difficulty_setting_array["count_barrier_difficulty_3"] = int(new_text)
	elif what_setting == "difficulty4":
		Setload.difficulty_setting_array["count_barrier_difficulty_4"] = int(new_text)
	
	
	
	print(new_text)
