extends CharacterBody2D
var state = 0

#Jonas S
var mouseTouch: bool = false
var areaEntered: bool = false
#Jonas S
func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	mouseTouch = true
#Jonas S
func _on_area_2d_body_entered(body):
	if body.name == "player":
		areaEntered = true
#Jonas S
func _on_area_2d_body_exited(body):
	if body.name == "player":
		areaEntered = false
#Jonas S
func _input(event : InputEvent):
	if (event is InputEventMouseButton && mouseTouch == true && areaEntered == true):
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if state < 3:
				DialogueManager.show_example_dialogue_balloon(load("res:///data/dialogue/tutorial_slime.dialogue"), "start")
			if state == 3:
				DialogueManager.show_example_dialogue_balloon(load("res://data/dialogue/tutorial_portal.dialogue"), "start")
				get_node("../portal").show()
				get_node("../portal").process_mode = 0
			mouseTouch = false
			areaEntered = false

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y,
		"state" : state
	}
	return save_dict
