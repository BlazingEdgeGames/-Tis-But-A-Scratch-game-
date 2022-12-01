extends KinematicBody2D

var enemybullet = preload("res://scenes/enemies/weapons/enemybullet.tscn")
var explosion = preload("res://scenes/enemies/weapons/explosion.tscn")

var velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()
var healthtemp = 0
var slowness = 1


var friction = 0.5
var speed 
var pushtime = 0.1
var dead = false
var moneydrop = 1
var knockback = false
var knock
var playerpos
var unoreverse = false

var canshoot = true
var switchdir = 1
var stolenshow = false
var walkstop = true

var type = 2   ## 1 = melee  2 = exploding  3 = shooter ##
var level = 1
var rotationspeed
var walk = 1
var deathexplode = false
var health = 100
var doubleloot = false
var breakleg = false
var lifesteal = false
var pain = false
var gravity = false


var push = 1

var col = 0



func _ready():

	get_parent().get_parent().get_parent().score += 1
	get_node("basicenemy/" + str(type) + "/" + str(level)).visible = true
	rng.randomize()
	var rot = rng.randi_range(1,2)
	if rot == 2:
		rot = -1
		get_node("basicenemy/1/1").flip_h = false
		get_node("basicenemy/1/2").flip_h = false
		get_node("basicenemy/1/3").flip_h = false
		get_node("basicenemy/2/1").flip_h = true
		get_node("basicenemy/2/2").flip_h = true
		get_node("basicenemy/2/3").flip_h = true
		get_node("basicenemy/3/1").flip_h = true
		get_node("basicenemy/3/2").flip_h = true
		get_node("basicenemy/3/3").flip_h = true
		
	match type:
		1:
			health = 200
			speed = 80
			rotationspeed = -200 * rot
			get_node("Area2D/melee").disabled = false
			get_node("basicenemy/1").disabled = false
			get_node("basicenemy/1").visible = true
			get_node("Area2D").name = str("melee" + str(level))
		2:
			health = 100
			speed = 100
			rotationspeed = 50 * rot
			get_node("Area2D/exploding").disabled = false
			get_node("basicenemy/2").disabled = false
			get_node("basicenemy/2").visible = true
			get_node("Area2D").name = str("exploding" + str(level))
		3:
			health = 150
			speed = 150
			rotationspeed = 400 * rot
			get_node("Area2D/shooter").disabled = false
			get_node("basicenemy/3").disabled = false
			get_node("basicenemy/3").visible = true
			get_node("Area2D").name = str("shooter" + str(level))
		
		
	breakleg = get_parent().get_parent().get_parent().breakleg
	if breakleg == true:
		rng.randomize()
		var brokenleg = rng.randi_range(0,100)
		if brokenleg <= 50:
			speed /= 2
		
		
		
	match level:
		1:
			scale *= 1
			health *= 1
			speed *= 1
			rotationspeed *= 1
			
		2:
			scale *= 1.25
			health *= 2
			speed *= 1.5
			if type == 1 or type == 2:
				rotationspeed *= 1.5
			elif type == 3:
				rotationspeed /= 1.5
		3:
			scale *= 1.5
			health *= 3
			speed *= 2
			if type == 1 or type == 2:
				rotationspeed *= 2
			elif type == 3:
				rotationspeed /= 2
			

	if type == 3:
		while true:
			yield(get_tree().create_timer(1.9),"timeout")
			if canshoot == true:
				get_node("enemyself/CollisionShape2D").disabled = true
				var instance = enemybullet.instance()
				instance.position = Vector2(position)
				get_parent().add_child(instance)
				yield(get_tree().create_timer(0.1),"timeout")
				get_node("enemyself/CollisionShape2D").disabled = false
			
	healthtemp = health
	
	while true:
		yield(get_tree().create_timer(0.02),"timeout")
		get_node("enemyaura/CollisionShape2D").disabled = false
		yield(get_tree().create_timer(0.02),"timeout")
		get_node("enemyaura/CollisionShape2D").disabled = true

	
func _process(delta):
	gravity = get_parent().get_parent().get_parent().gravity
	if healthtemp != health:
		get_parent().get_node("AnimationPlayer").play("enemydamageflash")
		healthtemp = health
	
	stolenshow = get_parent().get_parent().get_parent().stolenshow
	pain = get_parent().get_parent().get_parent().pain
	lifesteal = get_parent().get_parent().get_parent().lifesteal
	deathexplode = get_parent().get_parent().get_parent().deathexplode
	knockback = get_parent().get_parent().get_parent().knockback
	unoreverse = get_parent().get_parent().get_parent().unoreverse
	doubleloot = get_parent().get_parent().get_parent().doubleloot
	
	move_and_slide(velocity)
	
	velocity.x = lerp(velocity.x, 0, friction)
	velocity.y = lerp(velocity.y, 0, friction)
	
	playerpos = get_parent().get_parent().get_parent().get_node("body").get_global_position()
	
	if type == 3:
		get_node("basicenemy/3/enemyweapon").look_at(playerpos)
	rotation_degrees += rotationspeed * delta
	var dir = playerpos - get_global_position()
	var magnitude = sqrt((dir.x * dir.x) + (dir.y * dir.y))
	dir = dir / magnitude

	velocity = dir * speed * push * walk * switchdir * slowness
	
	if health <= 0 and dead == false:
		dead = true
		if type == 2 and deathexplode == true:
			var instance = explosion.instance()
			instance.position = Vector2(position)
			get_parent().add_child(instance)
			
		if level == 1:
			get_parent().get_parent().get_parent().coins += 1
		elif level == 2 or level == 3:
			get_parent().get_parent().get_parent().coins += 2
			
		if doubleloot == true:
			get_parent().get_parent().get_parent().coins += 1
		yield(get_tree().create_timer(0.02),"timeout")
		
		match type:
			1:
				get_parent().get_parent().get_parent().score += 10 * level
			2:
				get_parent().get_parent().get_parent().score += 15 * level
			3:
				get_parent().get_parent().get_parent().score += 20 * level
				
		get_parent().get_node("Particles2D").global_position = global_position
		get_parent().get_node("Particles2D").modulate = get_node("basicenemy").modulate
		get_parent().get_node("Particles2D").emitting = true
		
		
		queue_free()
		
	if stolenshow == true:
		switchdir = -0.8
		canshoot = false
		walkstop = false
	else:
		switchdir = 1
		canshoot = true
		walkstop = true
	
	if walkstop == false:
		walk = 1

	
func _on_basicenemy_area_entered(area):
	var damage = 0
	if area.name == "pellet":
		damage = 25
		health -= damage
		
		if knockback == true:
			push = -0.5
			yield(get_tree().create_timer(pushtime),"timeout")
			push = 1
			
	elif area.name == "bullet":
		damage = 65
		health -= damage
		
		if knockback == true:
			push = -1
			yield(get_tree().create_timer(pushtime),"timeout")
			push = 1
	elif area.name == "laser":
		damage = 28
		health -= damage
		
		if knockback == true:
			push = 0
			yield(get_tree().create_timer(pushtime),"timeout")
			push = 1
		
	elif area.name == "wingbullet":
		damage = 15
		health -= damage
		
		if knockback == true:
			push = -0.4
			yield(get_tree().create_timer(pushtime),"timeout")
			push = 1
	elif area.name == "shotwing":
		damage = 8
		health -= damage
		if knockback == true:
			push = -0.4
			yield(get_tree().create_timer(pushtime),"timeout")
			push = 1
			
	elif area.name == "explosion1":
		health -= 150
	elif area.name == "explosion2":
		health -= 250
	elif area.name == "explosion3":
		health -= 350
	elif area.name == "lemon":
		health -= 110
	
	if lifesteal == true:
		get_parent().get_parent().get_parent().health += damage * 20/100
		
	if pain == true:
		var tick = 0
		while tick < 3:
			yield(get_tree().create_timer(0.3),"timeout")
			health -= damage * 15/100
			tick += 1
			if damage > 0:
				get_node("gutpain").play()
		
		
func _on_Area2D_area_entered(area):
	if area.name == "playerarea":
		if type == 1 and unoreverse == true:
			if level == 1:
				health -= 10
			elif level == 2:
				health -= 20
			elif level == 3:
				health -= 40
		
		if type == 2:
			var instance = explosion.instance()
			instance.position = Vector2(position)
			instance.scale *= level
			get_parent().add_child(instance)
			get_parent().get_parent().get_parent().explosionshake()
			
			
			health = 0
		
		if type == 3 and walkstop == true:
			walk = 0


func _on_Area2D_area_exited(area):
	if area.name == "playerarea":
		if type == 3:
			walk = 1


func _on_enemyself_area_entered(area):
	if area.name == "enemybullet1":
		health -= 15
	if area.name == "enemybullet2":
		health -= 30
	if area.name == "enemybullet3":
		health -= 55



