extends Node2D


func _on_outdoor_pressed() -> void:
	get_tree().change_scene_to_file("res://Ebenen/ebene_2.tscn")

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y
	}
	return save_dict
