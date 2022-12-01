extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_shielditem_area_entered(area):
	if area.name == "playerarea":
		yield(get_tree().create_timer(0.02),"timeout")
		queue_free()


func _on_heartitem_area_entered(area):
	if area.name == "playerarea":
		yield(get_tree().create_timer(0.02),"timeout")
		queue_free()


func _on_speedboostitem_area_entered(area):
	if area.name == "playerarea":
		yield(get_tree().create_timer(0.02),"timeout")
		queue_free()


func _on_coinitem_area_entered(area):
	if area.name == "playerarea":
		yield(get_tree().create_timer(0.02),"timeout")
		queue_free()
