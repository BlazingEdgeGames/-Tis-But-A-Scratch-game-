extends KinematicBody2D

var velocity = Vector2.ZERO
var bulletspeed = 1000
var level
var unoreverse = false
var dir
var playerpos
var gravity = false

func _ready():
	level = get_parent().get_parent().get_node("basicenemy").level
	gravity = get_parent().get_parent().get_node("basicenemy").gravity
	unoreverse = get_parent().get_parent().get_node("basicenemy").unoreverse
	if level == 1:
		scale /= 1.5
	elif level == 2:
		bulletspeed = 1250
		scale /= 1.25
	elif level == 3:
		bulletspeed = 1500
		scale /= 1
	get_node("enemybullet").name = "enemybullet" + str(level)
	
	visible = false
	playerpos = get_parent().get_parent().get_node("basicenemy").playerpos
	


func _physics_process(delta):
	move_and_slide(velocity)
	
	
	if velocity == Vector2(0,0):
		look_at(playerpos)
		dir = playerpos - get_global_position()
		var magnitude = sqrt((dir.x * dir.x) + (dir.y * dir.y))
		dir = dir / magnitude
		visible = true
		velocity = dir * bulletspeed
		
	velocity += Vector2(0, int(gravity) * 5)

func _on_bullet_area_entered(area):
	if area.name == "basicenemy":
		queue_free()


func _on_enemybullet_body_entered(body):
	if body.name == "wall":
		queue_free()


func _on_enemybullet_area_entered(area):
	if area.name == "playerarea":
		if unoreverse == true:
			if level == 1:
				get_parent().get_parent().get_node_or_null("basicenemy").health -= 10
			elif level == 2:
				get_parent().get_parent().get_node_or_null("basicenemy").health -= 20
			elif level == 3:
				get_parent().get_parent().get_node_or_null("basicenemy").health -= 30
		queue_free()
	elif area.name == "shieldit":
		queue_free()
		
	elif area.name == "backshield":
		queue_free()
		
	elif area.name == "enemyself":
		queue_free()


