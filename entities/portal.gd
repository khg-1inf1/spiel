extends CharacterBody2D

func _on_area_2d_body_entered(body):
	print(body)
	print(get_node("/root/main/player"))
	if body == get_node("/root/main/player"):
		get_node("/root/main").set_current_level("level_1", false, 0, 0)
