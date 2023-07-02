extends CharacterBody2D

#Jonas S
@export var speed = 10
var chasePlayer = false
var player = null
#Jonas S
func _on_detection_area_body_entered(body):
	player = body
	chasePlayer = true
#Jonas S
func _on_detection_area_body_exited(_body):
	player = null
	chasePlayer = false
#Jonas S
func _physics_process(_delta):
	if chasePlayer:
		velocity = position.direction_to(player.position)*speed
		move_and_slide()
