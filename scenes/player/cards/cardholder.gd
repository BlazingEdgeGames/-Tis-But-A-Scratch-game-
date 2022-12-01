extends Area2D


var occupied = 0
var ability = 0
var ab = 0

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if occupied == 0 and ab != 0:
		ability = 0
		ab = 0
	if ab != ability:
		ab = ability
		


	
	
	if Input.is_action_just_pressed("abilityupdate"):
		if ability != 0:
			get_parent().get_parent().get_parent().get_parent().get_parent().abilities.append(ability)

