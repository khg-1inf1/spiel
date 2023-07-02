extends CharacterBody2D

@export var geschwindigkeit : float = 100 # Jonas S
# Variable geschwinigkeit ist vom Editor zugänglich

var stop : int = 1 # Jan

func isPlayer():
	pass

# Jan
func _ready(): 
	var _ui_manager = get_node("../userInterface")

# Jonas S
func _physics_process(_delta):
	# prozess der mit Simulationsgeschwindigkeit läuft
	
	var tastenrichtung = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	# Variable geschwindigkeit wird durch Tastendruck gesetzt
	
	velocity = tastenrichtung * geschwindigkeit
	# Bewegung des Spielers wird gesetzt
	
	move_and_slide()
	# Bewegung des Spielers wird ausgeführt

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y
	}
	return save_dict

func get_pos():
	return position
