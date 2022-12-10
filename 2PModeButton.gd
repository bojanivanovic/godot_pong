extends Button


func _ready():
	pass


func _on_2PModeButton_pressed():
	# set the game mode to 2 players
	Global.gameMode = 2
	# resume the game, this is needed after coming back to the main menu from the game, which pauses it
	get_tree().paused = false
	# start a new game
	get_tree().change_scene_to_file("res://Court.tscn")

