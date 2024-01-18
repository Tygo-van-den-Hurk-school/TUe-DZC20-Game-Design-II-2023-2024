extends Node

var selectedBlock = 1
var physicsMode = false
var current_grid
var popupVisible = false

func _input(event):
	if event.is_action_pressed("escape"):
		get_tree().quit()
