extends Control

@export var ui_manager : uiManager

func _ready():
	hide()
	ui_manager.connect("toggle_game_paused", _on_ui_manager_paused)

func _on_ui_manager_paused(is_paused : bool):
	if(is_paused):
		show()
		ui_manager.hotvis = false
	else:
		hide()
		ui_manager.hotvis = true

func _on_resume_pressed():
	ui_manager.game_paused = false


func _on_exit_pressed():
	ui_manager.game_paused = false
	get_node("../../..").set_current_level("startMenu", true, 0, 0)
	get_node("../../../startMenu")._ready()


func _on_save_pressed():
	SaveManager.save_game()
