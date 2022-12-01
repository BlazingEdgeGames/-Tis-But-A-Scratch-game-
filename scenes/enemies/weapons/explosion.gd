extends Area2D


var scalevalue = 1
var level

# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_parent().get_node("Particles2D").position = get_position()
	get_parent().get_node("Particles2D").emitting = true
	
	
	level = get_parent().get_parent().get_node("basicenemy").level
	name = "explosion" + str(level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if scalevalue < 20:
		scalevalue += 80 * delta
	else:
		queue_free()
	scale = Vector2(scalevalue, scalevalue)
	

