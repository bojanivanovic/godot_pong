extends Button


func _ready():
	print('wtf')
	pass

func _on_Button_pressed():
	# set the game mode to 1 player against an AI
	Global.gameMode = 1
	# resume the game, this is needed after coming back to the main menu from the game, which pauses it
	get_tree().paused = false
	# start a new game
	get_tree().change_scene_to_file("res://Court.tscn")
