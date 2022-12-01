extends KinematicBody2D

var pressed = false
var prepos
var placed = false
var areanames = ["player", "player2", "player3", "weapon", "weapon2", "enemy", "enemy2", "enemy3"]
var number = 0
export var price = 0

export var ability = 0

var type = 0

func _ready():
	
	
	match ability:
		1:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("A (not very) Loose Cannon")
			get_node("Description/description").text = str("A simple typical cannon that shoots cannon balls")
		
			get_node("Description/Button/auto").visible = false
			get_node("Description/Button/leftclick").visible = true
		
		2:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("Shotty")
			get_node("Description/description").text = str("A basic shotgun that shoots 6 pellets simultaneously")
		
			get_node("Description/Button/auto").visible = false
			get_node("Description/Button/leftclick").visible = true
		
		3:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("At The Speed Of Light")
			get_node("Description/description").text = str("A hitscan, unstoppable, and very cool laser gun!")
		
			get_node("Description/Button/auto").visible = false
			get_node("Description/Button/leftclick").visible = true
		
		4:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("Spread Your Wings")
			get_node("Description/description").text = str("Weapon bullets/rays burst into 3 smaller bullets/lasers")
		5:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("Time Heals All Wounds")
			get_node("Description/description").text = str("Slowly recovers health over time")
		6:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("The more, the merrier")
			get_node("Description/description").text = str("Gains an additional heart")
		7:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("Old But Gold")
			get_node("Description/description").text = str("Grandpa's old shovel automatically mines gold for you!")
		8:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("Opposites Attract")
			get_node("Description/description").text = str("Enemies attract bullets")
		9:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("Better Late Than Never")
			get_node("Description/description").text = str("Exploding enemies also explode when killed, dealing damage to nearby enemies")
		10:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("Classic Knockback")
			get_node("Description/description").text = str("It's in the name!")
		11:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("A Taste Of Your Own Medicine")
			get_node("Description/description").text = str("Ah yes... The classic Reverse Card! \nEnemies take damage when they damage you.")
		12:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("What Goes Up Must Come Down")
			get_node("Description/description").text = str("Applies gravity to all projectiles. \nNever ask how gravity works in a top down shooter!")
		13:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("Buy 1 get 1 free")
			get_node("Description/description").text = str("Doubles the coins gained after killing enemies")
		14:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("Frozen In Time")
			get_node("Description/description").text = str("Slows time for a short period and allows shooting stupidly fast")
		
			get_node("Description/Button/auto").visible = false
			get_node("Description/Button/1").visible = true
		
		15:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("When Life Gives You Lemons, MAKE BOMBS!!")
			get_node("Description/description").text = str("When activated, shoots an explosive lemon where you're aiming")
		
			get_node("Description/Button/auto").visible = false
			get_node("Description/Button/rightclick").visible = true
	
		16:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("Nerves Of Steel")
			get_node("Description/description").text = str("Gains additional speed near enemies and bullets")
		17:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("Break A Leg")
			get_node("Description/description").text = str("Enemies have a 50% chance of spawning with a broken leg")
		18:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("Typical Lifesteal")
			get_node("Description/description").text = str("Gains 20% lifesteal when damaging enemies")
		19:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("Got your back")
			get_node("Description/description").text = str("Adds a shield that always covers your back")
		20:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("Gut Wrenching Pain")
			get_node("Description/description").text = str("Damaging Enemies deals 3 extra ticks of 15% damage")
		21:
			get_node("icons/" + str(ability)).visible = true
			get_node("Description/title").text = str("Steal The Show")
			get_node("Description/description").text = str("When activated, enemies run away from you for a short period of time and shooters stop shooting")
			
			get_node("Description/Button/auto").visible = false
			get_node("Description/Button/2").visible = true
		
		
		
		
	
	price /= 3
	if get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().level != 0:
		price *= get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().level
	else:
		price *= 1

	price = int(price)
	
	prepos = position
	number = position.x + position.y
	if price != 0:
		get_node("locked").visible = true
		get_node("Button").disabled = true
		get_node("upgradepane").visible = false


func _process(delta):
	if Input.is_action_just_pressed("upgrademenu"):
		get_node("Description").visible = false
	
	if price != 0 and price <= get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().coins:
		get_node("locked/Lock").modulate = Color(0.9,0.71,0.08)
		get_node("locked/CenterContainer/pricetag").text = str(price)
		get_node("locked/CenterContainer/pricetag").self_modulate = Color(0.9,0.71,0.08)
	elif price != 0:
		get_node("locked/Lock").modulate = Color(0.78,0.78,0.78)
		get_node("locked/CenterContainer/pricetag").text = str(price)
		get_node("locked/CenterContainer/pricetag").self_modulate = Color(0.78,0.78,0.78)
	
	if pressed == true:
		position = get_global_mouse_position()
	name = str(ability)


func _on_Button_button_down():
	z_index = 2
	get_node("Area2D/CollisionShape2D").disabled = true
	pressed = true
	if placed == false:
		scale = Vector2(1.275,1.275)

func _on_Button_button_up():
	get_node("Area2D/CollisionShape2D").disabled = false
	pressed = false
	yield(get_tree().create_timer(0.02),"timeout")
	if placed == false:
		scale = Vector2(0.85,0.85)
		get_node("Tween").interpolate_property(get_node("."), "position", position, prepos, 0.01, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		get_node("Tween").start()
	


func _on_Area2D_area_entered(area):
	if pressed == false and area.name in areanames and get_parent().get_parent().get_node(area.name).occupied == 0:
		get_parent().get_parent().get_node(area.name).occupied = number
		get_parent().get_parent().get_node(area.name).ability = ability
		position = get_parent().get_parent().get_node(area.name).get_node("collision").global_position
		placed = true
	

func _on_Area2D_area_exited(area):
	if get_parent().get_parent().get_node(area.name).occupied == number:
		get_parent().get_parent().get_node(area.name).occupied = 0
		get_parent().get_parent().get_node(area.name).ability = 0
		placed = false
	


func _on_Area2D_body_entered(body):
	if type == 0:
		if body.name == "playercards":
			type = 1
			get_node("Area2D").set_collision_mask_bit(9, false)
			get_node("Area2D").set_collision_mask_bit(12, true)
		if body.name == "weaponcards":
			type = 2
			get_node("Area2D").set_collision_mask_bit(9, false)
			get_node("Area2D").set_collision_mask_bit(13, true)
		if body.name == "enemycards":
			get_node("Description").flip_h = true
			get_node("Description").position *= -1
			type = 3
			get_node("Area2D").set_collision_mask_bit(9, false)
			get_node("Area2D").set_collision_mask_bit(14, true)



func _on_purchase_pressed():
	if get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().coins >= price:
		get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().coins -= price
		price = 0
		get_node("locked").visible = false
		get_node("Button").disabled = false
		get_node("upgradepane").visible = true



func _on_purchase_mouse_entered():
	get_node("Description").visible = true


func _on_Button_mouse_entered():
	get_node("Description").visible = true


func _on_Button_mouse_exited():
	get_node("Description").visible = false


func _on_purchase_mouse_exited():
	get_node("Description").visible = false
