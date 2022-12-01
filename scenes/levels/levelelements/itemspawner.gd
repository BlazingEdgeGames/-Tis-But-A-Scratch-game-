extends Node2D


var heart = load("res://scenes/levels/levelelements/items/heart.tscn")
var shield = load("res://scenes/levels/levelelements/items/shield.tscn")
var speedboost = load("res://scenes/levels/levelelements/items/speedboost.tscn")
var coins = load("res://scenes/levels/levelelements/items/coins.tscn")

var rng = RandomNumberGenerator.new()

export var type = 1
export var random = true

var item = false

func _ready():
	if random == true:
		while true:
			yield(get_tree().create_timer(2),"timeout")
			if item == false:
				yield(get_tree().create_timer(16),"timeout")
				rng.randomize()
				var typetemp = rng.randi_range(1,4)
				
				
				
				match typetemp:
					1:
						var instance = heart.instance()
						instance.position = Vector2(position)
						get_parent().add_child(instance)
					2:
						var instance = shield.instance()
						instance.position = Vector2(position)
						get_parent().add_child(instance)
					3:
						var instance = speedboost.instance()
						instance.position = Vector2(position)
						get_parent().add_child(instance)
					4:
						var instance = coins.instance()
						instance.position = Vector2(position)
						get_parent().add_child(instance)
			
	else:
		if type == 1:
			while true:
				yield(get_tree().create_timer(2),"timeout")
				if item == false:
					yield(get_tree().create_timer(20),"timeout")
					
					var instance = heart.instance()
					instance.position = Vector2(position)
					get_parent().add_child(instance)
		elif type == 2:
			while true:
				
				yield(get_tree().create_timer(2),"timeout")
				if item == false:
					yield(get_tree().create_timer(20),"timeout")
					var instance = shield.instance()
					instance.position = Vector2(position)
					get_parent().add_child(instance)
		elif type == 3:
			while true:
				
				yield(get_tree().create_timer(2),"timeout")
				if item == false:
					yield(get_tree().create_timer(20),"timeout")
					var instance = speedboost.instance()
					instance.position = Vector2(position)
					get_parent().add_child(instance)
			
		elif type == 4:
			while true:
				
				yield(get_tree().create_timer(2),"timeout")
				if item == false:
					yield(get_tree().create_timer(20),"timeout")
					var instance = coins.instance()
					instance.position = Vector2(position)
					get_parent().add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_itemspawnerarea_area_entered(area):
	if area.name == "speedboostitem" or area.name == "heartitem" or area.name == "shielditem" or area.name == "coinitem":
		item = true


func _on_itemspawnerarea_area_exited(area):
	if area.name == "speedboostitem" or area.name == "heartitem" or area.name == "shielditem" or area.name == "coinitem":
		item = false
