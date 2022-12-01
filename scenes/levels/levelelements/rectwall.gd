extends KinematicBody2D


export var move = false
export var rotate = false
export var speed = 300
export var length = 2
export var direction = 0
export var rotationstrength : float = 0 


var dir = 1
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	var orilength = length
	length /= 2
	while true:
		yield(get_tree().create_timer(length),"timeout")
		dir *= -1
		length = orilength
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	velocity = move_and_slide(velocity)
	
	velocity.x = lerp(velocity.x, 0, 0.5) * int(move)
	velocity.y = lerp(velocity.y, 0, 0.5) * int(move)
	
	
	var ang = direction * PI/180
	
	velocity = Vector2(cos(ang),sin(ang)) * speed * dir * int(move)
	
	
	rotation += rotationstrength * int(rotate)
	
