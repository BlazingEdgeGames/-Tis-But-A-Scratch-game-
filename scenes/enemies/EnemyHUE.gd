extends Area2D

var col = 0


func _ready():
	while true:
		yield(get_tree().create_timer(0.07),"timeout")
		col = get_parent().get_parent().get_parent().get_parent().get_node("body/BG").modulate.h
		modulate.h = col + 0.5


