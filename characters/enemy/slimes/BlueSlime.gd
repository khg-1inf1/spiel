extends CharacterBody2D

@onready var animations = $AnimationPlayer
#Jonas S
@export var speed = 10
var chasePlayer = false
var player = null
var health = 50
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
	updateAnimation()
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
	enemy = area
	takeDamage()
func _on_hitbox_area_exited(_area):
	enemy = null
func takeDamage():
	if health == 0:
		die()
	else:
		health = health - 25
func die():
	if(once):
		if get_parent().name == "tutorial":
			get_node("/root/main/tutorial/tut_npc").state = get_node("/root/main/tutorial/tut_npc").state + 1
		$CollisionShape2D.call_deferred("set_disabled", true)
		$GPUParticles2D.restart()
		$DeathTimer.start()
		once = false
		$Sprite2D.hide()

func _on_death_timer_timeout():
	self.queue_free()

func updateAnimation():
	animations.play("idle")
