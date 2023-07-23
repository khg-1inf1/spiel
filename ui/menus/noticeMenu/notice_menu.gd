extends CanvasLayer

func _on_ready_pressed():
	get_node("..").set_current_level("tutorial", false, -325, -25)
	DialogueManager.show_example_dialogue_balloon(load("res://data/dialogue/tutorial_slime.dialogue"), "start")
