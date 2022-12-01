extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_pausemainmenu_pressed():
	Engine.time_scale = 1
	get_parent().get_parent().get_node("dead/menutransition").play("slide")
	yield(get_tree().create_timer(0.6),"timeout")
	get_tree().change_scene("res://main.tscn")


func _on_pausemainmenu_mouse_exited():
	get_node("Menu").scale /= 1.2


func _on_pausemainmenu_mouse_entered():
	get_node("Menu").scale *= 1.2


func _on_pauserestart_pressed():
	Engine.time_scale = 1
	get_tree().reload_current_scene()


func _on_pauserestart_mouse_exited():
	get_node("Restart").scale /= 1.2


func _on_pauserestart_mouse_entered():
	get_node("Restart").scale *= 1.2
