extends Control

@onready var button_click_sfx: AudioStreamPlayer2D = $"../Button_Click_SFX"
@onready var enemy_defeated_sfx: AudioStreamPlayer2D = $"../Enemy_Defeated_SFX"

var is_attacking = false
var deadEnemyMonster = 0

func _ready() -> void:
	randomize()

func _process(delta: float) -> void:
	# Show the health of the selected monster.
	var deadMonsters = 0
	var health = int(Game.selectedMonsters[get_parent().selected]["Health"])
	var maxHealth = int(Game.selectedMonsters[get_parent().selected]["MaxHealth"])
	if health > 0:
		$HPbar.value = health
		$HpText.text = str(health) + "/" + str(maxHealth)
		$Menu/GridContainer/Fight.disabled = false
		if Input.is_action_just_pressed("heal") and (Game.healthPotions > 0):
			button_click_sfx.play()
			if health == maxHealth:
				$"../Action".text = "You monster is already max health."
				$"../Action".show()
			else:
				if (health + 30) > maxHealth:
					Game.selectedMonsters[get_parent().selected]["Health"] = maxHealth
					$"../Player".get_child(get_parent().selected).Health = maxHealth
				else:
					Game.selectedMonsters[get_parent().selected]["Health"] += 30
					$"../Player".get_child(get_parent().selected).Health += 30
				Game.healthPotions -= 1
				$"../HealthPotionRemaining".text = "x" + str(Game.healthPotions)
				$"../HealthPotionRemaining".show()
		elif Input.is_action_just_pressed("heal") and (Game.healthPotions <= 0):
			$"../Action".text = "You are out of health postions."
			$"../Action".show()
				
	elif health <= 0 and get_parent().first_time_enter_fight == false:
		# Prompt the player to switch monsters
		$"../Action".text = "Your monster is out of health! Please switch to another."
		$"../Action".show()
		Game.selectedMonsters[get_parent().selected]["Health"] = 0
		$HPbar.value = 0
		$HpText.text = "0"
		$Menu/GridContainer/Fight.disabled = true
	# Show name and level of the monster.
	$Info.text = str(Game.selectedMonsters[get_parent().selected]["Name"]) + " lvl: " + str(Game.selectedMonsters[get_parent().selected]["Level"])
	
	# Showing the attack names.
	for i in Game.selectedMonsters[get_parent().selected]["Attacks"]:
		var path = "Fight_Menu/GridContainer/Attack" + str(((i) + 1))
		get_node(path).text = Game.selectedMonsters[get_parent().selected]["Attacks"][i]["Name"]
		
	#TODO: Might have to change the range of this when player actually captures monsters.
	for j in range(0, 3):
		var path = "Switch_Menu/GridContainer/Monster" + str(j + 1)
		get_node(path).text = Game.selectedMonsters[j]["Name"]
		if Game.selectedMonsters[j]["Health"] < 1:
			deadMonsters += 1
			get_node(path).add_theme_color_override("font_color", Color(0.5, 0.5, 0.5))  # Set text color to gray
			get_node(path).disabled = true
		else:
			get_node(path).disabled = false
			
	if deadMonsters == 3:
		$"../GameOver".show()
		await get_tree().create_timer(4).timeout
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_fight_pressed() -> void:
	# Hide menu
	button_click_sfx.play()
	$Menu.hide()
	$Fight_Menu/GridContainer/Attack1.grab_focus()
	$Fight_Menu.show()
	

func _on_back_pressed() -> void:
	# Show menu
	button_click_sfx.play()
	$Menu.show()
	$Fight_Menu.hide()
	$Switch_Menu.hide()
	

func _on_switch_pressed() -> void:
	button_click_sfx.play()
	$Menu.hide()
	$Switch_Menu.show()
	$Switch_Menu/GridContainer/Monster1.grab_focus()
	$Fight_Menu.hide()
	

func _on_flee_pressed() -> void:
	# get_parent().queue_free()
	button_click_sfx.play()
	if Global.current_scene == "world":
		get_tree().change_scene_to_file("res://scenes/world.tscn")
	elif Global.current_scene == "forest":
		get_tree().change_scene_to_file("res://scenes/forest.tscn")

func _on_attack_pressed(extra_arg_0: int) -> void:
	$Menu.hide()
	$Fight_Menu.hide()
	$Switch_Menu.hide()
	button_click_sfx.play()
	get_parent().first_time_enter_fight = false
	
	if Game.selectedMonsters[get_parent().selected]["Attacks"][extra_arg_0]["Target"] == "Monster":
		var tempDic = Game.selectedMonsters[get_parent().selected]["Attacks"]
		var damageDone = int(randi_range(tempDic[extra_arg_0]["Damage"], tempDic[extra_arg_0]["MaxDamage"]) * (1.2 ** (Game.selectedMonsters[get_parent().selected]["Level"] - 1)))
		# Added: Play attack animation (might have to wait so the attack regs and then the hit animation plays.
		$"../Action".text = "Your " + str(Game.selectedMonsters[get_parent().selected]["Name"]) + " " + tempDic[extra_arg_0]["Name"] + " for " + str(int(damageDone)) + " hp"
		$"../Player".get_child(get_parent().selected).attack()
		await get_tree().create_timer(1.0).timeout
		$"../Enemy".get_child(get_parent().enemy_selected).hit(damageDone)
		# Might have to change this part and change how battle is called from world in general
		# TODO: Change how battle scene is called from player and move it to the main world script.
		if $"../Enemy".get_child(get_parent().enemy_selected).Health > 0:
			get_parent().MonsterTurn()
		else:
			deadEnemyMonster += 1
			
			if deadEnemyMonster >= get_parent().enemy_array_size:
				$GainedXP.text = "Gained 10 XP!"
				$GainedXP.show()
				Game.addExp(10)
				enemy_defeated_sfx.play()
				await get_tree().create_timer(3.5).timeout
				if Game.selectedBossName == "first_boss":
					Global.first_enemy_defeated = true
				if Game.selectedBossName == "mushroom":
					Global.mushroom_defeated = true
				if Game.selectedBossName == "goblin":
					Global.goblin_defeated = true
				if Game.selectedBossName == "final_boss":
					Global.final_boss_defeated = true
					$"../Victory".show()
					await get_tree().create_timer(2).timeout
				_on_flee_pressed()
				
			else:
				await get_tree().create_timer(2).timeout
				$"../Enemy".get_child(get_parent().enemy_selected).hide()
				get_parent().enemy_selected += 1
				$"../Enemy".get_child(get_parent().enemy_selected).show()
				get_parent().MonsterTurn()
