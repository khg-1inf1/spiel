extends CharacterBody2D

@export var geschwindigkeit : float = 100 # Jonas S
# Variable geschwinigkeit ist vom Editor zugänglich
@onready var animations = $AnimationPlayer #Anja

var health : int = 100 # Jonas
var stop : int = 1 # Jan
var takeDamage : bool = false # Jonas
var enemy
var consume = true
var attack = true
var right = Vector2(0,0)
var left = Vector2(-22,0)
var maxHealth = 100
var play

# Jan
func _ready(): 
	var ui_manager = get_node("../userInterface")
	ui_manager.connect("invOpen", _on_inv_open)
	$HealthBar.value = health

# Jonas
func _physics_process(_delta):
	# prozess der mit Simulationsgeschwindigkeit läuft
	var tastenrichtung = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if tastenrichtung != Vector2(0, 0) and !play:
		get_node("walkPlayer").play()
		play = true
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
	if Inventory.get_selected() == {}:
		get_node("AttackBox/Weapon").set_texture(null)
	else:
		get_node("AttackBox/Weapon").set_texture(load("res://graphics/images/items/animations/%s" % Inventory.get_selected().icon))
# Jonas S
func _input(event : InputEvent):
	if (event is InputEventMouseButton && event.pressed && consume && attack):
		$AttackBox/AnimationPlayer.play("idle")
		if Inventory.get_selected() == {}:
			return
		if Inventory.get_selected().consumable == true:
			if event.button_index == MOUSE_BUTTON_LEFT:
				consumable()
		if Inventory.get_selected() == {}:
			return
		if Inventory.get_selected().damage > 0:
			if event.button_index == MOUSE_BUTTON_LEFT:
				$AttackBox/CollisionShape2D.disabled = false
				$AttackDuration.start(0.2)
				$AttackBox/AnimationPlayer.play("attack")
	if event.is_action_pressed("right"):
		$AttackBox.position = right
		$AttackBox/Weapon.set_flip_h(false)
	if event.is_action_pressed("left"):
		$AttackBox.position = left
		$AttackBox/Weapon.set_flip_h(true)
#Jonas S
func _on_attack_duration_timeout():
	$AttackBox/CollisionShape2D.disabled = true
# Jonas S
func consumable():
	if(consume):
		if Inventory.get_selected().potion == true:
			$AttackBox/AnimationPlayer.play("drink")
			get_node("drinkPlayer").play()
			health = health + Inventory.get_selected().health
			if health > maxHealth:
				health = maxHealth
			Inventory.set_item_quantity(Inventory.selected,  -1)
			consume = false
			$ConsumeDuration.start()
			$HealthBar.value = health
# Jonas
func _on_consume_duration_timeout():
	consume = true
func _on_hitbox_body_entered(body):
	takeDamage = true
	enemy = body
func _on_hitbox_body_exited(_body):
	takeDamage = false
	enemy = null
func _on_hit_timer_timeout():
	if health == 0:
		die()
	elif takeDamage == true:
		health = health - 25
		$HealthBar.value = health
		if health == 0:
			die()
	$HitTimer.start()
func die():
	health = 100
	$HealthBar.value = health
	print("you died")
	get_node("..").set_current_level("deathMenu", true, 0, 0)


func _on_audio_stream_player_finished():
	play = false
