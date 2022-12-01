extends Node2D


export var main = false


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(0.2),"timeout")
	get_node("AnimationPlayer").play("intro")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if main == true:
		get_tree().change_scene("res://main.tscn")
