extends KinematicBody2D

var wingspawn = preload("res://scenes/player/weapons/wings.tscn")
var velocity = Vector2.ZERO
var bulletspeed
var wings = false
var dir
var expired = false
var enemypos
var velo
var attracted = false
var attract = false
var gravity = false
var fall = 0

func _ready():
	
	gravity = get_parent().get_parent().gravity
	wings = get_parent().get_parent().wings
	attract = get_parent().get_parent().attract
	wings()
	visible = false
	bulletspeed = get_parent().get_parent().bulletspeed
	
func wings():
	if wings == true:
		yield(get_tree().create_timer(0.4),"timeout")
		velo = velocity
		var mag = sqrt((velo.x * velo.x) + (velo.y * velo.y))
		velo /= mag
		
		
		velocity = Vector2(0, 0)
		get_node("Sprite").visible = false
		get_node("CollisionShape2D").disabled = true
		get_node("attractionzone/CollisionShape2D").disabled = true
		expired = true
		var instance = wingspawn.instance()
		instance.position = Vector2(get_node("Sprite").position)
		add_child(instance)
		get_node("bullet/CollisionShape2D").disabled = true



func _physics_process(delta):
	move_and_slide(velocity)
	if gravity == true:
		fall = 1
	else:
		fall = 0
	
	
	if velocity == Vector2(0,0) and expired == false:
		look_at(get_global_mouse_position())
		var mouse = get_global_mouse_position()
		dir = mouse - get_global_position()
		var magnitude = sqrt((dir.x * dir.x) + (dir.y * dir.y))
		dir = dir / magnitude
		visible = true
		velocity = dir * bulletspeed
	
	velocity +=  fall * Vector2(0,1) * 20
	
	if attracted == true and attract == true:
		get_node("attractionzone/CollisionShape2D").disabled = true
		look_at(enemypos)
		dir = enemypos - get_global_position()
		var magnitude = sqrt((dir.x * dir.x) + (dir.y * dir.y))
		dir = dir / magnitude
		visible = true
		velocity += dir * 85
		get_node("attractionzone/CollisionShape2D").disabled = false
		


func _on_bullet_area_entered(area):
	if area.name == "basicenemy":
		queue_free()


func _on_attractionzone_area_entered(area):
	if area.name == "basicenemy" and attract == true:
		enemypos = area.global_position
		attracted = true


func _on_attractionzone_area_exited(area):
	if area.name == "basicenemy":
		attracted = false


func _on_bullet_body_entered(body):
	if body.name == "wall":
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
