extends Node

var current_level = ""
var menu_state = false
var system_nodes = []

# Jan + Lea
func _ready():
	system_nodes.append(get_node("player"))
	system_nodes.append(get_node("Camera2D"))
	system_nodes.append(get_node("userInterface"))
	set_current_level("startMenu", true, 0, 0)

# Jan + Lea
func get_current_level():
	return current_level

#Jan + Lea
func get_menu_state():
	return menu_state

# Jan + Lea
func set_current_level(path, is_menu, x, y):
	for node in get_children():
		if path in node.name:
			current_level = NodePath(node.name)
	menu_state = is_menu
	for i in get_children():
		i.hide()
		i.process_mode = 4
	get_node(current_level).show()
	get_node(current_level).process_mode = 0
	if is_menu:
		for i in system_nodes:
			i.hide()
			i.process_mode = 4
	else:
		for i in system_nodes:
			i.show()
			i.process_mode = 0
		var player = get_node("player")
		player.position.x = x
		player.position.y = y
