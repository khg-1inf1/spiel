extends CanvasLayer


func _on_play_pressed():
	get_node("..").set_current_level("level_1", false, 0, 0)

func _on_options_pressed():
	pass


func _on_exit_pressed():
	get_tree().quit()
