extends Node2D

func _on_outdoor_pressed() -> void:
	get_node("..").set_current_level("level_2", false, 0, 0)
