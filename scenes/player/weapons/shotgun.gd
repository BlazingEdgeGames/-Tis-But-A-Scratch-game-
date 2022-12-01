extends KinematicBody2D

var shotwingspawn = preload("res://scenes/player/weapons/shotwings.tscn")
var velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()

var lifetime = 2

var wings = false
var dir
var expired = false

var fall = 0

var shotgunspeed
var shotgunspread

var velo
var attracted = false
var attract = false
var gravity = false
var enemypos

func _ready():
	gravity = get_parent().get_parent().get_parent().gravity
	visible = false
	wings = get_parent().get_parent().get_parent().wings
	attract = get_parent().get_parent().get_parent().attract
	wings()
	shotgunspeed = get_parent().get_parent().get_parent().shotgunspeed
	shotgunspread = get_parent().get_parent().get_parent().shotgunspread
	yield(get_tree().create_timer(lifetime),"timeout")
	get_node("Sprite").visible = false
	get_node("CollisionShape2D").disabled = true
	queue_free()

func wings():
	if wings == true:
		yield(get_tree().create_timer(0.3),"timeout")
		velo = velocity
		var mag = sqrt((velo.x * velo.x) + (velo.y * velo.y))
		velo /= mag
		
		velocity = Vector2(0, 0)
		get_node("Sprite").visible = false
		get_node("CollisionShape2D").disabled = true
		get_node("attractionzone/CollisionShape2D").disabled = true

		expired = true
		var instance =shotwingspawn.instance()
		instance.position = Vector2(get_node("Sprite").position)
		add_child(instance)
		get_node("pellet/CollisionShape2D").disabled = true

func _physics_process(delta):
	if gravity == true:
		fall = 1
	else:
		fall = 0
	move_and_slide(velocity)
	
	
	if velocity == Vector2(0,0) and expired == false:
		rng.randomize()
		var mouse1 = get_global_mouse_position()
		var dir1 = mouse1 - get_global_position()
		var mag1 = sqrt((dir1.x * dir1.x) + (dir1.y * dir1.y))
		
		shotgunspread =  mag1 / shotgunspread
		
		var randomx = rng.randf_range(-shotgunspread, shotgunspread)
		var randomy = rng.randf_range(-shotgunspread, shotgunspread)
		look_at(get_global_mouse_position())
		var mouse = get_global_mouse_position() + Vector2(randomx, randomy)
		dir = mouse - get_global_position()
		var magnitude = sqrt((dir.x * dir.x) + (dir.y * dir.y))
		dir = dir / magnitude
		visible = true
		velocity = dir * shotgunspeed
	
	velocity +=  fall * Vector2(0,1) * 40
	
	if attracted == true and attract == true:
		get_node("attractionzone/CollisionShape2D").disabled = true
		look_at(enemypos)
		dir = enemypos - get_global_position()
		var magnitude = sqrt((dir.x * dir.x) + (dir.y * dir.y))
		dir = dir / magnitude
		visible = true
		velocity += dir * 130
		get_node("attractionzone/CollisionShape2D").disabled = false
		

func _on_pellet_area_entered(area):
	if area.name == "basicenemy":
		queue_free()


func _on_attractionzone_area_entered(area):
	if area.name == "basicenemy" and attract == true:
		enemypos = area.global_position
		attracted = true


func _on_attractionzone_area_exited(area):
	if area.name == "basicenemy":
		attracted = false


func _on_pellet_body_entered(body):
	if body.name == "wall":
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

