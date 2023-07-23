extends CharacterBody2D

func _on_area_2d_body_entered(body):
	if body == get_node("/root/main/player"):
		get_node("/root/main").set_current_level("level_1", false, 0, 0)

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y
	}
	return save_dict
