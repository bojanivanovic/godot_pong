extends Control


func _ready():
	pass



func _on_MenuQuit_pressed():
	# go back to the main menu
	get_tree().change_scene("res://Menu.tscn")

func _on_MenuResume_pressed():
	# hid the menu and resume the game
	self.visible = false
	get_tree().paused = false

