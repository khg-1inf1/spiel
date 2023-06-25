extends Node

var current_level = ""
var system_nodes = []
var level_nodes = []

# Jan + Lea
func _ready():
	system_nodes.append(get_node("player"))
	system_nodes.append(get_node("Camera2D"))
	system_nodes.append(get_node("userInterface"))
	for i in get_children():
		if !system_nodes.has(i):
			level_nodes.append(i)
	set_current_level("startMenu", true, 0, 0)

# Jan + Lea
func get_current_level():
	return current_level
# Jan + Lea
func set_current_level(path, is_menu, x, y):
	current_level = path
	for i in level_nodes:
		i.hide()
	get_node(path).show()
	if is_menu:
		for i in system_nodes:
			i.hide()
	else:
		for i in system_nodes:
			i.show()
		var player = get_node("player")
		player.position.x = x
		player.position.y = y

