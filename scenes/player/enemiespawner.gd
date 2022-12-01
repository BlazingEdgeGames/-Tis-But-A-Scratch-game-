extends Node2D

var rng = RandomNumberGenerator.new()

var basicenemy = preload("res://scenes/enemies/basicenemy.tscn")

var enabled = true

var level

var timespawn = 3

func _ready():
	level = get_parent().get_parent().level
	match level:
		
		0:
			timespawn = 6
			yield(get_tree().create_timer(6),"timeout")
			while true:
				yield(get_tree().create_timer(timespawn),"timeout")
				if enabled == true:
					if timespawn > 1:
						timespawn -= 0.0008
					rng.randomize()
					var pos = Vector2(rng.randf_range(-1,1), rng.randf_range(-1,1))
					rng.randomize()
					var mag = sqrt((pos.x * pos.x) + (pos.y * pos.y))
					pos /= mag
					var instance = basicenemy.instance()
					rng.randomize()
					var type = rng.randi_range(1,3)
					instance.get_node("basicenemy").type = type
					instance.get_node("basicenemy").level = 1
					instance.get_node("basicenemy").slowness = 0.5
					instance.position = Vector2(get_parent().get_node("body").position + pos * rng.randf_range(500 , 2000))
					add_child(instance)
			
		
		
		1:
			timespawn = 3
			while true:
				yield(get_tree().create_timer(timespawn),"timeout")
				if enabled == true:
					if timespawn > 1:
						timespawn -= 0.0008
					rng.randomize()
					var pos = Vector2(rng.randf_range(-1,1), rng.randf_range(-1,1))
					rng.randomize()
					var mag = sqrt((pos.x * pos.x) + (pos.y * pos.y))
					pos /= mag
					var instance = basicenemy.instance()
					rng.randomize()
					var type = rng.randi_range(1,3)
					instance.get_node("basicenemy").type = type
					instance.get_node("basicenemy").level = 1
					instance.position = Vector2(get_parent().get_node("body").position + pos * rng.randf_range(500 , 2000))
					add_child(instance)
			
		
	
		2:
			timespawn = 2.8
			while true:
				yield(get_tree().create_timer(timespawn),"timeout")
				if enabled == true:
					if timespawn > 0.8:
						timespawn -= 0.0008
					rng.randomize()
					var pos = Vector2(rng.randf_range(-1,1), rng.randf_range(-1,1))
					rng.randomize()
					var mag = sqrt((pos.x * pos.x) + (pos.y * pos.y))
					pos /= mag
					var instance = basicenemy.instance()
					rng.randomize()
					var type = rng.randi_range(1,3)
					instance.get_node("basicenemy").type = type
					rng.randomize()
					var level = rng.randi_range(1,2)
					instance.get_node("basicenemy").level = level
					instance.position = Vector2(get_parent().get_node("body").position + pos * rng.randf_range(500 , 2000))
					add_child(instance)
			
		
	
		3:
			timespawn = 2.6
			while true:
				yield(get_tree().create_timer(timespawn),"timeout")
				if enabled == true:
					if timespawn > 0.6:
						timespawn -= 0.001
					rng.randomize()
					var pos = Vector2(rng.randf_range(-1,1), rng.randf_range(-1,1))
					rng.randomize()
					var mag = sqrt((pos.x * pos.x) + (pos.y * pos.y))
					pos /= mag
					var instance = basicenemy.instance()
					rng.randomize()
					var type = rng.randi_range(1,3)
					instance.get_node("basicenemy").type = type
					rng.randomize()
					var level = rng.randi_range(2,3)
					instance.get_node("basicenemy").level = level
					instance.position = Vector2(get_parent().get_node("body").position + pos * rng.randf_range(500 , 2000))
					add_child(instance)
			
		
	
		4:
			timespawn = 2.4
			while true:
				yield(get_tree().create_timer(timespawn),"timeout")
				if enabled == true:
					if timespawn > 0.5:
						timespawn -= 0.001
					rng.randomize()
					var pos = Vector2(rng.randf_range(-1,1), rng.randf_range(-1,1))
					rng.randomize()
					var mag = sqrt((pos.x * pos.x) + (pos.y * pos.y))
					pos /= mag
					var instance = basicenemy.instance()
					rng.randomize()
					var type = rng.randi_range(1,3)
					instance.get_node("basicenemy").type = type
					instance.get_node("basicenemy").level = 3
					instance.position = Vector2(get_parent().get_node("body").position + pos * rng.randf_range(500 , 2000))
					add_child(instance)
				
		
	
#func _process(delta):
#	pass
