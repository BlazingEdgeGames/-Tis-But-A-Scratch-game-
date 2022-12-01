extends Node2D

var enemytriggers = ["exploding1","exploding2","exploding3","melee1","explosion1","enemybullet1","melee2","explosion2","enemybullet2","melee3","explosion3","enemybullet3"]

var bullet = preload("res://scenes/player/weapons/bullet.tscn")
var laser = preload("res://scenes/player/weapons/laser.tscn")
var shotgun = preload("res://scenes/player/weapons/shotgun.tscn")
var lemon = preload("res://scenes/player/weapons/lemon.tscn")

var bulletspeed = 1200
var shotgunspeed = 2000
var shotgunspread = 3
var lasertime = 0.1

var slowtime = 0.02

var pause = false
var tut = false
var timewait = false
var timestopped = false

var dead = false

export var coins = 0

var level


var abilities = []

export var health = 1800
var healthupdate = false

var score = 0

var shotgunrecoil = 400
var gunrecoil = 200
var laserrecoil = 0

var speed = 150
var friction = 0.15

var controller = false
var menucontroller = false

var shoot = true

var shieldit = false

var upgrademenu = false

var wait = false
var shake = false
var shake_amount = 15
var healthtemp

var cansteal = true
var stolenshow = false

export var weapon = 0   ####   1 = gun     2 = shotgun     3 = laser   ####

var wings = false
var timeheals = false
var extraheart = false
var gold = false
var attract = false
var deathexplode = false
var knockback = false
var unoreverse = false
var gravity = false
var doubleloot = false
var timestop = false
var lemons = false
var steelnerves = false
var breakleg = false
var lifesteal = false
var backshield = false
var pain = false
var stealtheshow = false





var evt = InputEventMouseButton.new()
var crosshair = load("res://assets/crosshair.png")

func _ready():
	level = get_parent().level
	slowtime = GlobalVars.slowtime
	
	if level == 1:
		coins += 20
	elif level == 2:
		coins += 15
	elif level == 3:
		coins += 10
	elif level == 4:
		coins += 10
	
		
	Input.set_custom_mouse_cursor(crosshair, Input.CURSOR_ARROW, Vector2(50,50))

	
	healthtemp = health
	get_node("body/upgrademenu").visible = upgrademenu
	while true:
		yield(get_tree().create_timer(0.5),"timeout")
		if timeheals == true and extraheart == false and health < 1800:
			health += 20
		elif timeheals == true and extraheart == true and health < 2400:
			health += 20
			
		yield(get_tree().create_timer(0.5),"timeout")
		if gold == true:
			coins += 0.3
			get_node("AnimationPlayer").play("goldflash")
			
			
		score += 0.5
		get_node("body/hud/score/score").text = str(int(score / 10))
		
		if tut == true:
			get_node("body/upgrademenu/upgradehints").visible = true

func click():
	evt.button_index = BUTTON_LEFT
	evt.position = get_viewport().get_mouse_position()
	evt.pressed = true
	get_tree().input_event(evt)
	evt.pressed = false
	get_tree().input_event(evt) 


func _process(delta):
	
	if shieldit == true:
		get_node("body/weapon/shielditem/shieldit/Collision").disabled = false
	else:
		get_node("body/weapon/shielditem/shieldit/Collision").disabled = true
		
	
	if shake == true:
		get_node("body/Camera2D").set_offset(Vector2(rand_range(-1.0, 1.0) * shake_amount, rand_range(-1.0, 1.0) * shake_amount))

	
	
	if health <= 0 and dead == false:
		get_node("body/audio/playerexplosion").play()
		get_node("body/playerarea/CollisionShape2D2").disabled = true
		dead = true
		shoot = false
		upgrademenu = false
		get_node("body/upgrademenu").visible = false
		Engine.time_scale = 0.2
		shake = true
		yield(get_tree().create_timer(0.03),"timeout")
		shake = false
		yield(get_tree().create_timer(0.2),"timeout")
		shake = true
		get_node("body/Sprite").visible = false
		get_node("body/playershards").visible = true
		
		get_node("body/weapon/gun").visible = false
		get_node("body/weapon/laser").visible = false
		get_node("body/weapon/shotgun").visible = false
		get_node("body/playershards/AnimationPlayer").playback_speed = 2
		get_node("body/playershards/AnimationPlayer").play("explode")
		yield(get_tree().create_timer(0.04),"timeout")
		shake = false
		yield(get_tree().create_timer(0.3),"timeout")
		get_node("AnimationPlayer").playback_speed = 6
		get_node("AnimationPlayer").play("game over")
		
		pause = true
		get_node("body/hud/pause/AnimationPlayer").playback_speed = 7
		get_node("body/hud/pause/AnimationPlayer").play("pause")
		
		
	
	
	
	if Input.is_action_just_pressed("ability2") and stealtheshow == true and cansteal == true:
		cansteal = false
		stolenshow = true
		yield(get_tree().create_timer(2),"timeout")
		stolenshow = false
		yield(get_tree().create_timer(10),"timeout")
		cansteal = true
	
	
	
	
	if controller == false and menucontroller == true:
		if Input.is_action_just_pressed("shoot"):
			evt.button_index = BUTTON_LEFT
			evt.position = get_viewport().get_mouse_position()
			evt.pressed = true
			get_tree().input_event(evt)
		if Input.is_action_just_released("shoot"):
			evt.button_index = BUTTON_LEFT
			evt.pressed = false
			get_tree().input_event(evt) 
		
		var rup = Input.get_action_strength("rup")
		var rdown = Input.get_action_strength("rdown")
		var rright = Input.get_action_strength("rright")
		var rleft = Input.get_action_strength("rleft")
	
		var yr = rup - rdown
		var xr = rleft - rright
		print(Vector2(xr,yr))
		Input.warp_mouse_position(get_viewport().get_mouse_position() - Vector2(xr,yr) * 10)
	 
	
	
	if healthtemp > health:
		get_node("AnimationPlayer").play("damageflash")
		healthtemp = health
		get_node("body/audio/playerdamaged").play()
	elif healthtemp < health:
		get_node("AnimationPlayer").play("healflash")
		healthtemp = health
		get_node("body/audio/timeheals").play()
	
	if extraheart == true and health > 2400:
		health = 2400
	elif extraheart == false and health > 1800:
		health = 1800
	
	get_node("body/hud/coins/coins").text = str(int(coins))
	get_node("body/upgrademenu/coins/coins").text = str(int(coins))
	
	if Input.is_action_just_pressed("rightclick") and lemons == true and wait == false and shoot == true:
		wait = true
		var instance = lemon.instance()
		instance.position = Vector2(get_node("body").position)
		add_child(instance)
		yield(get_tree().create_timer(1.5),"timeout")
		wait = false
	
	
	if Input.is_action_just_pressed("ability1") and timestop == true and timewait == false and shoot == true:
		get_node("audio/stoptime").play()
		timewait = true
		timestopped = true
		Engine.time_scale = 0.1
		yield(get_tree().create_timer(0.6),"timeout")
		Engine.time_scale = 1
		timestopped = false
		yield(get_tree().create_timer(12),"timeout")
		timewait = false
	if Input.is_action_just_pressed("ability1") and timestopped == true:
		get_node("audio/unstoptime").play()
		Engine.time_scale = 1
		timestopped = false
		yield(get_tree().create_timer(12),"timeout")
		timewait = false
	
	
	if dead == false:
		if controller == true and (get_node("body").rmag > 0.1 or get_node("body").rmag < -0.1):
			get_node("body/weapon").look_at(get_global_mouse_position())
		elif controller == false:
			get_node("body/weapon").look_at(get_global_mouse_position())
	
	
	if backshield == true:
		get_node("body/weapon/backshield").visible = true
		get_node("body/weapon/backshield/backshield/CollisionPolygon2D").disabled = false
		get_node("body/weapon/backshield/backshieldkin/CollisionPolygon2D").disabled = false
	else:
		get_node("body/weapon/backshield").visible = false
		get_node("body/weapon/backshield/backshield/CollisionPolygon2D").disabled = true
		get_node("body/weapon/backshield/backshieldkin/CollisionPolygon2D").disabled = true
	
	
	
	
	if dead == false:
		if weapon == 0:
			get_node("body/weapon/gun").visible = false
			get_node("body/weapon/laser").visible = false
			get_node("body/weapon/shotgun").visible = false
		if weapon == 1:
			get_node("body/weapon/gun").visible = true
			get_node("body/weapon/laser").visible = false
			get_node("body/weapon/shotgun").visible = false
		elif weapon == 2:
			get_node("body/weapon/gun").visible = false
			get_node("body/weapon/laser").visible = false
			get_node("body/weapon/shotgun").visible = true
		elif weapon == 3:
			get_node("body/weapon/gun").visible = false
			get_node("body/weapon/laser").visible = true
			get_node("body/weapon/shotgun").visible = false
		
	if Input.is_action_just_pressed("upgrademenu") and upgrademenu == false and dead == false:
		get_node("body/upgrademenu").visible = true
		upgrademenu = true
		shoot = false
		if controller == true:
			controller = false 
			menucontroller = true
		Engine.time_scale = slowtime
	elif Input.is_action_just_pressed("upgrademenu") and upgrademenu == true and Input.is_action_pressed("shoot") == false:
		yield(get_tree(),"idle_frame")
		yield(get_tree(),"idle_frame")
		if menucontroller == true:
			controller = true 
			menucontroller = false
		get_node("body/upgrademenu").visible = false
		upgrademenu = false
		shoot = true
		if timestopped == false:
			Engine.time_scale = 1
		abilityreset()
		enableabilities()
		abilityupdate()
		abilityupdate2()
	
	if Input.is_action_just_pressed("cancel") and pause == false and upgrademenu == false:
		shoot = false
		pause = true
		Engine.time_scale = slowtime
		get_node("body/hud/pause/AnimationPlayer").playback_speed = 1.5/slowtime
		get_node("body/hud/pause/AnimationPlayer").play("pause")
	elif Input.is_action_just_pressed("cancel") and pause == true and upgrademenu == false:
		pause = false
		Engine.time_scale = 1
		get_node("body/hud/pause/AnimationPlayer").playback_speed = 2
		get_node("body/hud/pause/AnimationPlayer").play_backwards("pause")
		shoot = true
	
	if extraheart == false:
		if healthupdate == true:
			healthupdate = false
			health -= 600
			print(health)
		health()
		get_node("body/hud/hearts/4").visible = false
	else:
		health2()
		get_node("body/hud/hearts/4").visible = true
		if healthupdate == false:
			healthupdate = true
			health += 600
			print(health)
	
	gun()
	laser()
	shotgun()
	
	if upgrademenu == true:
		abilityreset()
		enableabilities()
		abilityupdate()
		


func abilityupdate2():
	var i = 0
	while i < 60:
		i += 1
		enableabilities()
		abilityupdate()


func abilityupdate():
	abilities.clear()
	Input.action_press("abilityupdate")
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	yield(get_tree(),"idle_frame")
	Input.action_release("abilityupdate")


func gun():
	if Input.is_action_just_pressed("shoot") and weapon == 1 and shoot == true:
		var instance = bullet.instance()
		instance.position = Vector2(get_node("body").position)
		add_child(instance)
		get_node("body/weapon/Particles2D").emitting = false
		get_node("body/weapon/Particles2D").emitting = true
	
func laser():
	if Input.is_action_just_pressed("shoot") and weapon == 3 and shoot == true:
		var instance = laser.instance()
		instance.position = Vector2(get_node("body").position)
		add_child(instance)
		get_node("body/weapon/Particles2D").emitting = false
		get_node("body/weapon/Particles2D").emitting = true

func shotgun():
	if Input.is_action_just_pressed("shoot") and weapon == 2 and shoot == true:
		var instance = shotgun.instance()
		instance.position = Vector2(get_node("body").position)
		add_child(instance)
		get_node("body/weapon/Particles2D").emitting = false
		get_node("body/weapon/Particles2D").emitting = true

func health():
	if health >= 1500:
		get_node("body/hud/hearts/1").frame = 0
		get_node("body/hud/hearts/2").frame = 0
		get_node("body/hud/hearts/3").frame = 0
	elif health >= 1200:
		get_node("body/hud/hearts/1").frame = 1
		get_node("body/hud/hearts/2").frame = 0
		get_node("body/hud/hearts/3").frame = 0
	elif health >= 900:
		get_node("body/hud/hearts/1").frame = 2
		get_node("body/hud/hearts/2").frame = 0
		get_node("body/hud/hearts/3").frame = 0
	elif health >= 600:
		get_node("body/hud/hearts/1").frame = 2
		get_node("body/hud/hearts/2").frame = 1
		get_node("body/hud/hearts/3").frame = 0
	elif health >= 300:
		get_node("body/hud/hearts/1").frame = 2
		get_node("body/hud/hearts/2").frame = 2
		get_node("body/hud/hearts/3").frame = 0
	elif health > 0:
		get_node("body/hud/hearts/1").frame = 2
		get_node("body/hud/hearts/2").frame = 2
		get_node("body/hud/hearts/3").frame = 1
	elif health <= 0:
		get_node("body/hud/hearts/1").frame = 2
		get_node("body/hud/hearts/2").frame = 2
		get_node("body/hud/hearts/3").frame = 2



func health2():
	if health >= 2100:
		get_node("body/hud/hearts/1").frame = 0
		get_node("body/hud/hearts/2").frame = 0
		get_node("body/hud/hearts/3").frame = 0
		get_node("body/hud/hearts/4").frame = 0
	elif health >= 1800:
		get_node("body/hud/hearts/1").frame = 1
		get_node("body/hud/hearts/2").frame = 0
		get_node("body/hud/hearts/3").frame = 0
		get_node("body/hud/hearts/4").frame = 0
	elif health >= 1500:
		get_node("body/hud/hearts/1").frame = 2
		get_node("body/hud/hearts/2").frame = 0
		get_node("body/hud/hearts/3").frame = 0
		get_node("body/hud/hearts/4").frame = 0
	elif health >= 1200:
		get_node("body/hud/hearts/1").frame = 2
		get_node("body/hud/hearts/2").frame = 1
		get_node("body/hud/hearts/3").frame = 0
		get_node("body/hud/hearts/4").frame = 0
	elif health >= 900:
		get_node("body/hud/hearts/1").frame = 2
		get_node("body/hud/hearts/2").frame = 2
		get_node("body/hud/hearts/3").frame = 0
		get_node("body/hud/hearts/4").frame = 0
	elif health >= 600:
		get_node("body/hud/hearts/1").frame = 2
		get_node("body/hud/hearts/2").frame = 2
		get_node("body/hud/hearts/3").frame = 1
		get_node("body/hud/hearts/4").frame = 0
	elif health >= 300:
		get_node("body/hud/hearts/1").frame = 2
		get_node("body/hud/hearts/2").frame = 2
		get_node("body/hud/hearts/3").frame = 2
		get_node("body/hud/hearts/4").frame = 0
	elif health > 0:
		get_node("body/hud/hearts/1").frame = 2
		get_node("body/hud/hearts/2").frame = 2
		get_node("body/hud/hearts/3").frame = 2
		get_node("body/hud/hearts/4").frame = 1
	elif health <= 0:
		get_node("body/hud/hearts/1").frame = 2
		get_node("body/hud/hearts/2").frame = 2
		get_node("body/hud/hearts/3").frame = 2
		get_node("body/hud/hearts/4").frame = 2


func explosionshake():
	shake_amount = 6
	shake = true
	yield(get_tree().create_timer(0.04),"timeout")
	shake = false
	shake_amount = 15

func abilityreset():
	weapon = 0
	wings = false
	timeheals = false
	extraheart = false
	gold = false
	attract = false
	deathexplode = false
	knockback = false
	unoreverse = false
	gravity = false
	doubleloot = false
	timestop = false
	lemons = false
	steelnerves = false
	breakleg = false
	lifesteal = false
	backshield = false
	pain = false
	stealtheshow = false

func enableabilities():
	if 1 in abilities:
		weapon = 1
	if 2 in abilities:
		weapon = 2
	if 3 in abilities:
		weapon = 3

	if 4 in abilities:
		wings = true
	if 5 in abilities:
		timeheals = true
	if 6 in abilities:
		extraheart = true
	if 7 in abilities:
		gold = true
	if 8 in abilities:
		attract = true
	if 9 in abilities:
		deathexplode = true
	if 10 in abilities:
		knockback = true
	if 11 in abilities:
		unoreverse = true
	if 12 in abilities:
		gravity = true
	if 13 in abilities:
		doubleloot = true
	if 14 in abilities:
		timestop = true
	if 15 in abilities:
		lemons = true
	if 16 in abilities:
		steelnerves = true
	if 17 in abilities:
		breakleg = true
	if 18 in abilities:
		lifesteal = true
	if 19 in abilities:
		backshield = true
	if 20 in abilities:
		pain = true
	if 21 in abilities:
		stealtheshow = true



func _on_playerarea_area_entered(area):
		
	if area.name == "melee1":
		health -= 10
		
	elif area.name == "explosion1":
		health -= 500
	
	elif area.name == "enemybullet1":
		health -= 50
		
	if area.name == "melee2":
		health -= 20
		
	elif area.name == "explosion2":
		health -= 700
	
	elif area.name == "enemybullet2":
		health -= 75
		
	if area.name == "melee3":
		health -= 40
		
	elif area.name == "explosion3":
		health -= 850
	
	elif area.name == "enemybullet3":
		health -= 110
	
	elif area.name == "heartitem":
		health += 300
		
	elif area.name == "shielditem":
		get_node("body/weapon/shielditem/shieldit/Sprite").visible = true
		shieldit = true
		
	elif area.name == "speedboostitem":
		get_node("body").speedboost = 1.08
		yield(get_tree().create_timer(2),"timeout")
		get_node("body").speedboost = 1
	
	elif area.name == "coinitem":
		coins += 5


func _on_aura_area_entered(area):
	if area.name in enemytriggers:
		if steelnerves == true:
			get_node("body").speed = 300


func _on_aura_area_exited(area):
	if area.name in enemytriggers:
		get_node("body").speed = 150

	

func _on_shieldit_area_entered(area):
	if area.name == "enemybullet1" or area.name == "enemybullet2" or area.name == "enemybullet3":
		get_node("body/weapon/shielditem/shieldit/Sprite").visible = false
		shieldit = false


func _on_levelaudio_finished():
	get_node("levelaudioloop").play()
