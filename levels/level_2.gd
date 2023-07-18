extends Node2D


func _on_outdoor_pressed():
		get_node("..").set_current_level("level_1", false, 0, 0)

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y
	}
	return save_dict

@warning_ignore("native_method_override")
func hide():
	get_node("TileMap").get_tileset().set_physics_layer_collision_layer(1, 0)
	super.hide()

@warning_ignore("native_method_override")
func show():
	get_node("TileMap").get_tileset().set_physics_layer_collision_layer(1, 2)
	super.show()
