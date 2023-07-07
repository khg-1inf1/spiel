extends Node

var char_pos_x
var char_pos_y
var char_pos_menu
var char_pos_lvl
var items
var new = []

# Jan + Lea
func save_game():
	var save_game = FileAccess.open("user://game.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	var player_dict = {
		"pos_x" : get_node("/root/main/player").get_position().x,
		"pos_y" : get_node("/root/main/player").get_position().y,
		"menu_state" : get_node("/root/main").get_menu_state(),
		"level" : get_node("/root/main").get_current_level()
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
	if not FileAccess.file_exists("user://game.save"):
		return
	for i in get_tree().get_nodes_in_group("Persist"):
		if get_tree().get_nodes_in_group("Persist") != []:
			i.free()
	var save_game = FileAccess.open("user://game.save", FileAccess.READ)
	# Read player data
	var pos_string = save_game.get_line()
	var pos_json = JSON.new()
	var _pos_parse = pos_json.parse(pos_string)
	var pos_data = pos_json.get_data()
	char_pos_x = pos_data["pos_x"]
	char_pos_y = pos_data["pos_y"]
	char_pos_menu = pos_data["menu_state"]
	char_pos_lvl = pos_data["level"]
	
	# Read inv data
	var inv_string = save_game.get_line()
	var inv_json = JSON.new()
	var _inv_parse = inv_json.parse(inv_string)
	var inv_data = inv_json.get_data()
	items = inv_data["items"]
	Inventory.load_items(items)
	
	# Read map data
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result  = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var node_data = json.get_data()
		var children = get_node(node_data["parent"]).get_children()
		for ch in children:
			if ch.get_groups().has("Persist"):
				if !new.has(ch):
					ch.free()
		var new_object = load(node_data["filename"]).instantiate()
		new.append(new_object)
		
		new_object.name = node_data["filename"].split("/")[-1].split(".")[0]
		get_node(node_data["parent"]).add_child(new_object, true)
		
		
		new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])

func get_char_pos_x():
	return char_pos_x

func get_char_pos_y():
	return char_pos_y

func get_char_pos_menu():
	return char_pos_menu

func get_char_pos_lvl():
	return char_pos_lvl
