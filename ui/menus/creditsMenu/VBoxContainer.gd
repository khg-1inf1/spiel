extends VBoxContainer


func move():
	position.y = get_viewport().size.y

func _process(delta):
	if position.y + size.y < 0:
		get_node("../../exit").position.y = get_viewport().size.y / 2
		get_node("../../exit").show()
	position.y = position.y -1


func _on_exit_pressed():
	get_node("../..").set_current_level("startMenu", true, 0, 0)
	get_node("../../startMenu")._ready()
