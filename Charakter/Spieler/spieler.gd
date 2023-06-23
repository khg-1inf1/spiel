extends CharacterBody2D

@export var geschwindigkeit : float = 100 # Jonas S
# Variable geschwinigkeit ist vom Editor zugänglich

var stop : int = 1 # Jan

# Jan
func _ready(): 
	var game_manager = get_node("../GameManager")
	game_manager.connect("inv_open_modifier", _set_stop_modifier)

# Jan
func _set_stop_modifier(modifier : int):
	stop = modifier

# Jonas S
func _physics_process(_delta):
	# prozess der mit Simulationsgeschwindigkeit läuft
	
	var tastenrichtung = Vector2(
		Input.get_action_strength("rechts") - Input.get_action_strength("links"),
		Input.get_action_strength("unten") - Input.get_action_strength("oben")
	)
	# Variable geschwindigkeit wird durch Tastendruck gesetzt
	
	velocity = tastenrichtung * geschwindigkeit * stop
	# Bewegung des Spielers wird gesetzt
	
	move_and_slide()
	# Bewegung des Spielers wird ausgeführt


