extends CanvasLayer

var monsterTest = preload("res://scenes/final_boss.tscn")
var monster_first_boss = preload("res://scenes/test_enemy.tscn")
# Called when the node enters the scene tree for the first time.
@onready var monster_change_land: AudioStreamPlayer2D = $Monster_change_land

var selected = 0

var enemy_selected = 0

var first_time_enter_fight = true

var enemy_array_size = Game.selectedBoss.size()

func _ready() -> void:
	$GameOver.hide()
	randomize()
		# Show enemy monster
	#var montemp = monsterTest.instantiate()
	#montemp.Health = 15
	#$Enemy.add_child(montemp)
	#montemp.flip_h = true
	
	if Game.selectedBossName == "final_boss":
		var bossTemp = monsterTest.instantiate()
		bossTemp.flip_h = true
		$Node2D.add_child(bossTemp)
		$Node2D.show()
	elif Game.selectedBossName == "first_boss":
		var bossTemp = monster_first_boss.instantiate()
		$Node2D.add_child(bossTemp)
		$Node2D.show()
	
	for i in Game.selectedBoss:
		var montemp = Game.selectedBoss[i]["Scene"].instantiate()
		montemp.flip_h = true
		montemp.name = Game.selectedBoss[i]["Name"]
		montemp.Health = int(Game.selectedBoss[i]["Health"] * (1.1 ** (Game.selectedBoss[i]["Level"] - 1)))
		if montemp.Health <= 0:
			enemy_selected += 1
		montemp.hide()
		$Enemy.add_child(montemp)
	$Enemy.get_child(enemy_selected).show()
	monster_change_land.play()
	
	$UI/GainedXP.hide()
	$UI/Fight_Menu.hide()
	$UI/Switch_Menu.hide()
	$UI/Menu.hide()
	$HealthPotionRemaining.text = "x" + str(Game.healthPotions)
	$HealthPotionRemaining.show()
	$UI/Menu/GridContainer/Fight.grab_focus()
	
	# Wait a second to add a little more drama of loading into a battle.
	await get_tree().create_timer(1.0).timeout
	
	# Show player monster
	for i in Game.selectedMonsters:
		var monTemp = Game.selectedMonsters[i]["Scene"].instantiate()
		monTemp.name = Game.selectedMonsters[i]["Name"]
		monTemp.Health = int(Game.selectedMonsters[i]["Health"])
		if monTemp.Health <= 0:
			selected += 1
		monTemp.hide()
		$Player.add_child(monTemp)
	$Player.get_child(selected).show()
	monster_change_land.play()
	$UI/Menu.show()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_capture_pressed() -> void:
	pass # Replace with function body.
	
func MonsterTurn() -> void:
	$UI/Menu.hide()
	$UI/Fight_Menu.hide()
	$UI/Switch_Menu.hide()
	var tempDic = Game.selectedBoss[enemy_selected]["Attacks"]
	var attack_range = randi_range(0,2)
	var attack_damage = int(randi_range(tempDic[attack_range]["Damage"], tempDic[attack_range]["MaxDamage"]) * (1.2 ** (Game.selectedBoss[enemy_selected]["Level"] - 1)))
	
	var damage = randi_range(20, 40)
	
	# Perhaps appear to wait
	await get_tree().create_timer(1.5).timeout
	$Action.text = "Enemy is thinking.."
	await get_tree().create_timer(2.0).timeout
	
	print(attack_damage)
		
	$Enemy.get_child(enemy_selected).attack_back()
	await get_tree().create_timer(1.0).timeout
	$Player.get_child(selected).hit(attack_damage)
	
	# TODO: Add a function that randomly chooses an attack out of the 3 choices and uses that for the print out for Action.text
	await get_tree().create_timer(1.5).timeout
	$Action.text = "Enemy " + str(Game.selectedBoss[enemy_selected]["Name"]) + " attacked using " + tempDic[attack_range]["Name"] + " for " + str(attack_damage) + " hp"
	Game.selectedMonsters[selected]["Health"] -= attack_damage
	print($Player.get_child(selected)["Health"])
	print($Player.get_child(selected).Health)
	
	await get_tree().create_timer(1).timeout
	$UI/Menu/GridContainer/Fight.grab_focus()
	$UI/Menu.show()
	


func _on_monster_pressed(extra_arg_0: int) -> void:
	print(extra_arg_0)
	# Switch to the selected monster
	$Player.get_child(selected).hide()
	selected = extra_arg_0
	$Player.get_child(selected).show()
	monster_change_land.play()

	# Update action text
	$Action.text = "You switched to " + Game.selectedMonsters[selected]["Name"] + "!"
	$Action.show()
