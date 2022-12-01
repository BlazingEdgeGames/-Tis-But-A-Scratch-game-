extends Node2D


var level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("player").tut = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
