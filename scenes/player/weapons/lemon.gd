extends KinematicBody2D

var velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()
var mousepos
var lemonspeed = 750
var dir
var scalevalue = 1
var stop = false
var dist

var lemona = false

func _ready():
	get_node("lemon/CollisionShape2D").disabled = true
	mousepos = get_global_mouse_position()
	yield(get_tree().create_timer(0.2),"timeout")
	
func _physics_process(delta):
	move_and_slide(velocity)
	rng.randomize()
	var side = rng.randi_range(1,2)
	
	if velocity == Vector2(0,0) and stop == false:
		dir = mousepos - get_global_position()
		var magnitude = sqrt((dir.x * dir.x) + (dir.y * dir.y))
		dir = dir / magnitude
		visible = true
		
		
		if side == 1:
			side = -1
		elif side == 2:
			side = 1
		
		velocity = dir.rotated(deg2rad(90 * side)) * 2000
		
	
	rotation_degrees += side * 8


	if stop == false:
		dir = mousepos - get_global_position()
		var magnitude = sqrt((dir.x * dir.x) + (dir.y * dir.y))
		dir = dir / magnitude
		dist = get_global_position().distance_to(mousepos)
		print(dist)

		velocity += dir * 300
		

		velocity.x = lerp(velocity.x, 0, 0.2)
		velocity.y = lerp(velocity.y, 0, 0.2)
	
	if stop == true:
		get_parent().get_node("Particles2D").position = get_position()
		get_parent().get_node("Particles2D").emitting = true
	
	
	if dist < 20:
		
		stop = true
		get_parent().get_parent().explosionshake()
		velocity = Vector2(0,0)
		get_node("Sprite").visible = false
		get_node("lemon/explosion").visible = true
		get_node("lemon/CollisionShape2D").disabled = false
		
		if scalevalue < 36:
			scalevalue += 200 * delta
		else:
			queue_free()
		scale = Vector2(scalevalue, scalevalue)


	
	if stop == true and lemona == false:
		lemona = true
		get_parent().get_node("explosion").position = position
		get_parent().get_node("explosion").play()
