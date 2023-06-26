extends Node

# Jan + Lea
func save_game():
	var save_game = FileAccess.open("user://save/game.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	var player_dict = {
		"pos_x" : get_node("/root/main/player").get_position().x,
		"pos_y" : get_node("/root/main/player").get_position().y
	}
	var player_string = JSON.stringify(player_dict)
	save_game.store_line(player_string)
	var inv_data = Inventory.save()
	var inv_string = JSON.stringify(inv_data)
	save_game.store_line(inv_string)
	for node in save_nodes:
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
		var node_data = node.call("save")
		var json_string = JSON.stringify(node_data)
		save_game.store_line(json_string)

# Jan + Lea
func load_game():
	if not FileAccess.file_exists("user://save/game.save"):
		return
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()
	var save_game = FileAccess.open("user://save/game.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result  = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var node_data = json.get_data()
		var new_object = load(node_data["filename"]).instantiate()
		for i in get_node(node_data["parent"]).get_children():
			if i.name == node_data["filename"]:
				get_node(node_data["parent"]).remove_child(i)		
		get_node(node_data["parent"]).add_child(new_object)
		new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i. node_data[i])
