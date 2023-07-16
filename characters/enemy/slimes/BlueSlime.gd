extends CharacterBody2D

#Jonas S
@export var speed = 10
var chasePlayer = false
var player = null
var health = 50
var takeDamage = false
var enemy
var once = true
#Jonas S
func isSlime():
	pass
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
#Jan? -Jonas S
func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y
	}
	return save_dict

func _on_hitbox_area_entered(area):
	takeDamage = true
	enemy = area
func _on_hitbox_area_exited(_area):
	takeDamage = false
	enemy = null
func _on_hit_timer_timeout():
	if health == 0:
		die()
	elif takeDamage == true:
		health = health - 25
	$HitTimer.start()
func die():
	print("slime died")
	if(once):
		$GPUParticles2D.restart()
		$DeathTimer.start()
		once = false
		$Sprite2D.hide()
		$CollisionShape2D.disabled = true

func _on_death_timer_timeout():
	self.queue_free()
