extends Button

func _on_outdoor_pressed() -> void:
	get_tree().change_scene_to_file("res://Ebenen/ebene_2.tscn")
