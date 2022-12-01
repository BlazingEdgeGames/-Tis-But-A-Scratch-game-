extends Line2D


var point = Vector2()
export var length = 10


func _ready():
	pass 


func _process(delta):
	global_position = Vector2(0,0)
	
	point = get_parent().global_position
	add_point(point)
	
	while get_point_count() > length:
		remove_point(0)
	
