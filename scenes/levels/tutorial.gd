extends Node2D


var level = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("player/enemiespawner").enabled = false
	get_node("AnimationPlayer").play("movement")
	yield(get_tree().create_timer(5),"timeout")
	get_node("AnimationPlayer").play("purchase1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("upgrademenu"):
		get_node("AnimationPlayer").playback_speed = 10
		get_node("AnimationPlayer").play("purchase2")
