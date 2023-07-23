extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ready_pressed():
	get_node("..").set_current_level("tutorial", false, -325, -25)
	DialogueManager.show_example_dialogue_balloon(load("res://data/dialogue/tutorial_slime.dialogue"), "start")
