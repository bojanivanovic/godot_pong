extends Control


func _ready():
	pass



func _on_MenuQuit_pressed():
	# go back to the main menu
	get_tree().change_scene_to_file("res://Menu.tscn")

func _on_MenuResume_pressed():
	# hid the menu and resume the game
	self.visible = false
	get_tree().paused = false

func _on_MenuRestart_pressed():
	self.visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Court.tscn")

