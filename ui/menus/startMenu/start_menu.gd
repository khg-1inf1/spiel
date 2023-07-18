extends CanvasLayer

func _on_new_pressed():
	get_node("..").set_current_level("noticeMenu", true, 0, 0)

func _on_load_pressed():
	SaveManager.load_game()
	get_node("..").set_current_level(SaveManager.get_char_pos_lvl(), SaveManager.get_char_pos_menu(), SaveManager.get_char_pos_x(), SaveManager.get_char_pos_y())

func _on_options_pressed():
	pass

func _on_exit_pressed():
	get_tree().quit()

func _on_delete_pressed():
	DirAccess.remove_absolute("user://game.save")
	_ready()

func _ready():
	if FileAccess.file_exists("user://game.save"):
		get_node("VBoxContainer/new").hide()
		get_node("VBoxContainer/load").show()
		get_node("VBoxContainer/delete").show()
	else:
		get_node("VBoxContainer/new").show()
		get_node("VBoxContainer/load").hide()
		get_node("VBoxContainer/delete").hide()
