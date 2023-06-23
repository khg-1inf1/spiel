extends Control

@export var game_manager : gameManager

func _ready():
	hide()
	game_manager.connect("toggle_game_paused", _on_game_manager_paused)

func _on_game_manager_paused(is_paused : bool):
	if(is_paused):
		show()
	else:
		hide()

func _on_resume_pressed():
	game_manager.game_paused = false


func _on_exit_pressed():
	game_manager.game_paused = false
	get_tree().change_scene_to_file("res://GameManager/startMenu.tscn")

# Jan + Lea
func _on_save_pressed():
	var save_game = FileAccess.open("user://game.save", FileAccess.WRITE)
	var inv = Inventory.get_items()
	var inv_string = JSON.stringify(inv)
	save_game.store_line(inv_string)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
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
