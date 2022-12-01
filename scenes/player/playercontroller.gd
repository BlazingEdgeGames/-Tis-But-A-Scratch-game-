extends KinematicBody2D


var velocity = Vector2.ZERO

var friction
var speed
var shotgunrecoil
var gunrecoil
var controller
var mpos
var rmag = 0
var speedboost = 1

export var walk = 1

var dead = false

func _ready():
	
	friction = get_parent().friction
	speed = get_parent().speed
	shotgunrecoil = get_parent().shotgunrecoil
	gunrecoil = get_parent().gunrecoil

func _physics_process(delta):
	dead = get_parent().dead
	controller = get_parent().controller
	move_and_slide(velocity)
	
	velocity.x = lerp(velocity.x, 0, friction)
	velocity.y = lerp(velocity.y, 0, friction)


	if get_parent().weapon == 2 and Input.is_action_just_pressed("shoot") and get_parent().shoot == true:
		var mouse = get_global_mouse_position()
		var dir = mouse - get_global_position()
		var magnitude = sqrt((dir.x * dir.x) + (dir.y * dir.y))
		dir = dir / magnitude
		visible = true
		velocity += -dir * shotgunrecoil

	if get_parent().weapon == 1 and Input.is_action_just_pressed("shoot") and get_parent().shoot == true:
		var mouse = get_global_mouse_position()
		var dir = mouse - get_global_position()
		var magnitude = sqrt((dir.x * dir.x) + (dir.y * dir.y))
		dir = dir / magnitude
		visible = true
		velocity += -dir * gunrecoil
	
	if dead == false:
		if controller == false:
			Controls()
		if controller == true:
			Controller()
	
	velocity *= walk * speedboost

func Controls():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_pressed("up"):
		velocity.y += -speed
	if Input.is_action_pressed("down"):
		velocity.y += speed
	if Input.is_action_pressed("left"):
		velocity.x += -speed
	if Input.is_action_pressed("right"):
		velocity.x += speed

func Controller():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	var lup = Input.get_action_strength("lup")
	var ldown = Input.get_action_strength("ldown")
	var lright = Input.get_action_strength("lright")
	var lleft = Input.get_action_strength("lleft")
	
	velocity.y += -speed * lup
	velocity.y += speed * ldown
	velocity.x += -speed * lleft
	velocity.x += speed * lright


	var rup = Input.get_action_strength("rup")
	var rdown = Input.get_action_strength("rdown")
	var rright = Input.get_action_strength("rright")
	var rleft = Input.get_action_strength("rleft")
	
	var yr = rup - rdown
	var xr = rleft - rright
	rmag = sqrt(xr * xr + yr * yr)
	mpos = Vector2(xr, yr)
	print(rmag)
	Input.warp_mouse_position(Vector2(get_global_transform_with_canvas().origin) - mpos * 200)
	
