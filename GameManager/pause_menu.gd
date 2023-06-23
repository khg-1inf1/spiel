extends Control

@export var game_manager : gameManager

func _ready():
	hide()
	game_manager.connect("toggle_game_paused", _on_game_manager_paused)

func _on_game_manager_paused(is_paused : bool):
	if(is_paused):
		show()
	else:
		hide()

func _on_resume_pressed():
	game_manager.game_paused = false


func _on_exit_pressed():
	game_manager.game_paused = false
	get_tree().change_scene_to_file("res://GameManager/startMenu.tscn")
