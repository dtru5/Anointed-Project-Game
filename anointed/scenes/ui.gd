extends Control


func _process(delta: float) -> void:
	# Show the health of the selected monster.
	var deadMonsters = 0
	var health = Game.selectedMonsters[get_parent().selected]["Health"]
	if health > 0:
		$HPbar.value = health
		$HpText.text = str(health)
		$Menu/GridContainer/Fight.disabled = false
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
	# Show the number of remaining health.
	# $HpText.text = str(Game.selectedMonsters[get_parent().selected]["Health"])
	
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
	$Menu.hide()
	$Fight_Menu/GridContainer/Attack1.grab_focus()
	$Fight_Menu.show()
	

func _on_back_pressed() -> void:
	# Show menu
	$Menu.show()
	$Fight_Menu.hide()
	$Switch_Menu.hide()
	

func _on_switch_pressed() -> void:
	$Menu.hide()
	$Switch_Menu.show()
	$Switch_Menu/GridContainer/Monster1.grab_focus()
	$Fight_Menu.hide()
	

func _on_flee_pressed() -> void:
	# get_parent().queue_free()
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_attack_pressed(extra_arg_0: int) -> void:
	get_parent().first_time_enter_fight = false
	if Game.selectedMonsters[get_parent().selected]["Attacks"][extra_arg_0]["Target"] == "Monster":
		var tempDic = Game.selectedMonsters[get_parent().selected]["Attacks"]
		# Added: Play attack animation (might have to wait so the attack regs and then the hit animation plays.
		$"../Player".get_child(get_parent().selected).attack()
		await get_tree().create_timer(2.4).timeout
		$"../Enemy".get_child(0).hit(tempDic[extra_arg_0]["Damage"])
		$"../Action".text = "Your " + str(Game.selectedMonsters[get_parent().selected]["Name"]) + " attacked for " + str(tempDic[0]["Damage"]) + " hp"
		# Might have to change this part and change how battle is called from world in general
		# TODO: Change how battle scene is called from player and move it to the main world script.
		await get_tree().create_timer(2.0).timeout
		if $"../Enemy".get_child(0).Health > 0:
			get_parent().MonsterTurn()
		else:
			$GainedXP.text = "Gained 10 XP!"
			$GainedXP.show()
			Game.addExp(10)
			await get_tree().create_timer(3.5).timeout
			_on_flee_pressed()
