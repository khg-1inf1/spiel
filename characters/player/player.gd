extends CharacterBody2D

@export var geschwindigkeit : float = 100 # Jonas S
# Variable geschwinigkeit ist vom Editor zugänglich
@onready var animations = $AnimationPlayer #Anja

var stop : int = 1 # Jan

# Jan
func _ready(): 
	var ui_manager = get_node("../userInterface")
	ui_manager.connect("invOpen", _on_inv_open)
	
# Jonas
func _physics_process(_delta):
	# prozess der mit Simulationsgeschwindigkeit läuft
	var tastenrichtung = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	# Variable geschwindigkeit wird durch Tastendruck gesetzt
	
	velocity = tastenrichtung * geschwindigkeit * stop
	# Bewegung des Spielers wird gesetzt
	
	move_and_slide()
	# Bewegung des Spielers wird ausgeführt
	updateAnimation() #Anja
	#Rechts/Links Animation

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y
	}
	return save_dict

func _on_inv_open(a):
	if a:
		stop = 0
	else:
		stop = 1

func get_pos():
	return position
	
#Anja
func updateAnimation():
	if velocity.length() == 0:
		animations.stop()
	else:
		var direction = "right"
		if velocity.x < 0: direction = "left"
	
	
		animations.play("Walk_" + direction)
