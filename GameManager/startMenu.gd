extends Control

@onready var load_button = $VBoxContainer/load
@onready var new_button = $VBoxContainer/new

func _ready():
	if not FileAccess.file_exists("user://game.save"):
		load_button.hide()
	else:
		new_button.hide()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Ebenen/ebene_1.tscn")


func _on_options_pressed():
	pass


func _on_exit_pressed():
	get_tree().quit()


func _on_load_pressed():
	if not FileAccess.file_exists("user://game.save"):
		return
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		node.queue_free()
	
	var save_game = FileAccess.open("user://game.save", FileAccess.READ)
	var inv_loaded = false
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var node_data = json.get_data()
		if not inv_loaded:
			var items = []
			print(node_data)
			for key in node_data:
				items.append(key)
			Inventory.set_items(items)
			inv_loaded = true
		else:
			var new_object = load(node_data["filename"]).instantiate()
			get_node(node_data["parent"]).add_child(new_object)
			new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])
			for i in node_data.keys():
				if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
					continue
				new_object.set(i, node_data[i])
	get_tree().change_scene_to_file("res://Ebenen/ebene_1.tscn")
