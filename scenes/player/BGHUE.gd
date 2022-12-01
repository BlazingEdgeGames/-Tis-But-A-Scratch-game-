extends Sprite


var col = 0.444
var rng = RandomNumberGenerator.new()
export var time = 0.1

func _ready():
	rng.randomize()
	col = rng.randf_range(0,1)
	while true:
		yield(get_tree().create_timer(time),"timeout")
		col += 0.001
		if col >= 1:
			col = 0
		modulate.h = col


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
