extends Node2D

var rng = RandomNumberGenerator.new()
var difficulty = 0
var options = false
var credits = false
var slowdown = 0.1
var menucursor = load("res://assets/cursormenu.png")

var tut = preload("res://scenes/levels/simpletutorial.tscn")
var lv1 = preload("res://scenes/levels/level1.tscn")
var lv2 = preload("res://scenes/levels/level2.tscn")
var lv3 = preload("res://scenes/levels/level3.tscn")
var lv4 = preload("res://scenes/levels/level4.tscn")



func _ready():
	
	Input.set_custom_mouse_cursor(menucursor, Input.CURSOR_ARROW)
	
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), GlobalVars.sfxvolume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), GlobalVars.musicvolume)
	get_node("options/sliders/music").value = GlobalVars.sfxvolume
	get_node("options/sliders/sfx").value = GlobalVars.musicvolume
	
	
	
	get_node("options/sliders/slowdown").value = 1/GlobalVars.slowtime
	
	rng.randomize()
	get_node("AnimationPlayer").advance(rng.randf_range(0,19.9))
	

 


func _process(delta):
	if Input.is_action_just_pressed("cancel"):
		get_tree().quit()
	
		
	match difficulty:
		0:
			get_node("ui/start/difficulty").text = "Tutorial"
		1:
			get_node("ui/start/difficulty").text = "Easy"
		2:
			get_node("ui/start/difficulty").text = "Normal"
		3:
			get_node("ui/start/difficulty").text = "Hard"
		4:
			get_node("ui/start/difficulty").text = "Very Hard"
		




func _on_right_pressed():
	if difficulty < 4:
		difficulty += 1


func _on_left_pressed():
	if difficulty > 0:
		difficulty -= 1


func _on_start_pressed():
	if difficulty != 0:
		get_tree().change_scene(("res://scenes/levels/level" + str(difficulty) + ".tscn"))
	else:
		get_tree().change_scene("res://scenes/levels/simpletutorial.tscn")
		


func _on_credits_mouse_entered():
	get_node("ui/Credits/Creditsbutton").scale *= 1.5


func _on_credits_mouse_exited():
	get_node("ui/Credits/Creditsbutton").scale /= 1.5


func _on_options_mouse_entered():
	get_node("ui/Options/Optionsbutton").scale *= 1.3


func _on_options_mouse_exited():
	get_node("ui/Options/Optionsbutton").scale /= 1.3


func _on_start_mouse_entered():
	get_node("ui/start/Startbutton").scale *= 1.2


func _on_start_mouse_exited():
	get_node("ui/start/Startbutton").scale /= 1.2


func _on_quit_mouse_entered():
	get_node("ui/quit/quitbutton").scale *= 1.6


func _on_quit_mouse_exited():
	get_node("ui/quit/quitbutton").scale /= 1.6


func _on_quit_pressed():
	get_tree().quit()



func _on_mainthemestart_finished():
	get_node("mainthemebeginning").play()
	get_node("AnimationPlayer2").play("BGPulse")
	get_node("credits/labels/heart").play("heartbeat")
	
func _on_mainthemebeginning_finished():
	get_node("mainthemeloop").play()


func _on_options_pressed():
#	get_node("ui/1Px").visible = false
#	get_node("ui/start").visible = false
#	get_node("ui/Options").visible = false
#	get_node("ui/Credits").visible = false
#	get_node("ui/quit").visible = false

	if options == false:
		options = true
		get_node("options/AnimationPlayer").play("options")
	else:
		options = false
		get_node("options/AnimationPlayer").play_backwards("options")







func _on_sfx_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	GlobalVars.sfxvolume = value


func _on_music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	GlobalVars.musicvolume = value


func _on_slowdown_value_changed(value):
	if value != 11:
		slowdown = 1/value
		GlobalVars.slowtime = slowdown
		get_node("options/sliders/freeze").visible = false
	else:
		slowdown = 0.00001
		GlobalVars.slowtime = slowdown
		get_node("options/sliders/freeze").visible = true
		
	


func _on_credits_pressed():
	if credits == false:
		credits = true
		get_node("credits/AnimationPlayer").play("credits")
	else:
		credits = false
		get_node("credits/AnimationPlayer").play_backwards("credits")
	
