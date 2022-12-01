extends Node2D





# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_mainmenu_mouse_entered():
	get_node("Menu").scale *= 1.2


func _on_mainmenu_mouse_exited():
	get_node("Menu").scale /= 1.2


func _on_restart_mouse_entered():
	get_node("Restart").scale *= 1.2


func _on_restart_mouse_exited():
	get_node("Restart").scale /= 1.2


func _on_mainmenu_pressed():
	Engine.time_scale = 1
	get_parent().get_node("menutransition").play("slide")
	yield(get_tree().create_timer(0.6),"timeout")
	get_tree().change_scene("res://main.tscn")


func _on_restart_pressed():
	Engine.time_scale = 1
	get_tree().reload_current_scene()

