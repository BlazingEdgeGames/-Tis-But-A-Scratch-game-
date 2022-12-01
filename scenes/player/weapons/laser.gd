extends KinematicBody2D


var lasertime

var fadeoutanimtime = 0.07

var wings

# Called when the node enters the scene tree for the first time.
func _ready():
	
	wings = get_parent().get_parent().wings
	get_node("Particles2D").emitting = true
	
	lasertime = get_parent().get_parent().lasertime
	look_at(get_global_mouse_position())
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	wings()
	get_node("laser/laser/Sprite").visible = true
	get_parent().get_node("AnimationPlayer").play("laserfadein")
	get_node("laser/laser").disabled = false
	yield(get_tree().create_timer(lasertime),"timeout")
	get_node("laser/laser").disabled = true
	get_parent().get_node("AnimationPlayer").play("laserfadeout")
	yield(get_tree().create_timer(fadeoutanimtime),"timeout")
	get_node("laser/laser").visible = false
	
	if wings == false:
		yield(get_tree().create_timer(1),"timeout")
		get_parent().queue_free()


func wings():
	if wings == true:
		get_node("Particles2D2").emitting = true
		get_node("Particles2D3").emitting = true
		
		
		yield(get_tree().create_timer(0.05),"timeout")
		get_node("laser/laser2/Sprite").visible = true
		get_node("laser/laser3/Sprite").visible = true
		get_parent().get_node("AnimationPlayer").play("laserfadein2")
		get_node("laser/laser2").disabled = false
		get_node("laser/laser3").disabled = false
		yield(get_tree().create_timer(lasertime),"timeout")
		get_node("laser/laser2").disabled = true
		get_node("laser/laser3").disabled = true
		get_parent().get_node("AnimationPlayer").play("laserfadeout2")
		
		yield(get_tree().create_timer(1),"timeout")
		get_parent().queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
