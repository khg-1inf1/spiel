extends CharacterBody2D

func _on_area_2d_body_entered(body):
	if body == get_node("/root/main/player"):
		get_node("/root/main").set_current_level("creditsMenu", false, 0, 0)
		get_node("/root/main/creditsMenu/VBoxContainer").move()
		get_node("/root/BackgroundPlayer").stop()
		get_node("/root/main/creditsMenu/AudioStreamPlayer").play()

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y
	}
	return save_dict
