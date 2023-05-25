extends CharacterBody2D

@export var geschwindigkeit : float = 100
# Variable geschwinigkeit ist vom Editor zugänglich

func _physics_process(_delta):
	# prozess der mit Simulationsgeschwindigkeit läuft
	
	var tastenrichtung = Vector2(
		Input.get_action_strength("rechts") - Input.get_action_strength("links"),
		Input.get_action_strength("unten") - Input.get_action_strength("oben")
	)
	# Variable geschwindigkeit wird durch Tastendruck gesetzt
	
	velocity = tastenrichtung * geschwindigkeit
	# Bewegung des Spielers wird gesetzt
	
	move_and_slide()
	# Bewegung des Spielers wird ausgeführt

