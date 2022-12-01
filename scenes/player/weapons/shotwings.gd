extends KinematicBody2D


var velocity = Vector2.ZERO

var lifetime = 2

export var angle = 0

var shotwingspeed = 1600

var enemypos
var attracted = false
var attract = false
var wait = true
var dir

func _ready():
	attract = get_parent().get_parent().get_parent().attract
	visible = false
	yield(get_tree().create_timer(lifetime),"timeout")
	get_node("Sprite").visible = false
	get_node("CollisionShape2D").disabled = true



func _physics_process(delta):
	move_and_slide(velocity)
	
	
	if velocity == Vector2(0,0):
		dir = get_parent().get_parent().get_parent().velo
		visible = true
		
		var arcos = acos(dir.x)
		var arcsin = asin(dir.y)
		var ang
		if arcsin > 0:
			ang = arcos
		if arcsin < 0:
			ang = -arcos
			
		ang += angle * PI/180
		
		velocity = Vector2(cos(ang),sin(ang)) * shotwingspeed

	if attracted == true and attract == true:
		get_node("attractionzone/CollisionShape2D").disabled = true
		look_at(enemypos)
		dir = enemypos - get_global_position()
		var magnitude = sqrt((dir.x * dir.x) + (dir.y * dir.y))
		dir = dir / magnitude
		visible = true
		velocity += dir * 140
		get_node("attractionzone/CollisionShape2D").disabled = false
		

func _on_shotwing_area_entered(area):
	if area.name == "basicenemy":
		queue_free()


func _on_attractionzone_area_entered(area):
	if area.name == "basicenemy" and attract == true:
		enemypos = area.global_position
		attracted = true


func _on_attractionzone_area_exited(area):
	if area.name == "basicenemy":
		attracted = false


func _on_shotwing_body_entered(body):
	if body.name == "wall":
		queue_free()



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
