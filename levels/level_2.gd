extends Node2D


func _on_outdoor_pressed():
		get_node("..").set_current_level("level_1", false, 0, 0)
