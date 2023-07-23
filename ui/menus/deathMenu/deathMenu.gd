extends CanvasLayer

func _on_respawn_pressed():
	get_node("..").set_current_level("tutorial", false, -325, -25)
	
