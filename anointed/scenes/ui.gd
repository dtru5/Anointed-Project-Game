extends Control

func _process(delta: float) -> void:
	# Show the health of the selected monster.
	$HPbar.value = Game.selectedMonsters[get_parent().selected]["Health"]
	# Show name and level of the monster.
	$Info.text = str(Game.selectedMonsters[get_parent().selected]["Name"]) + " lvl: " + str(Game.selectedMonsters[get_parent().selected]["Level"])
	# Show the number of remaining health.
	$HpText.text = str(Game.selectedMonsters[get_parent().selected]["Health"])
	
	# Showing the attack names.
	for i in Game.selectedMonsters[get_parent().selected]["Attacks"]:
		var path = "Fight_Menu/GridContainer/Attack" + str(((i) + 1))
		get_node(path).text = Game.selectedMonsters[get_parent().selected]["Attacks"][i]["Name"]

func _on_fight_pressed() -> void:
	# Hide menu
	$Menu.hide()
	$Fight_Menu/GridContainer/Attack1.grab_focus()
	$Fight_Menu.show()
	

func _on_back_pressed() -> void:
	# Show menu
	$Menu.show()
	$Fight_Menu/GridContainer/Attack1.grab_focus()
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
	if Game.selectedMonsters[get_parent().selected]["Attacks"][extra_arg_0]["Target"] == "Monster":
		var tempDic = Game.selectedMonsters[get_parent().selected]["Attacks"]
		# Added: Play attack animation (might have to wait so the attack regs and then the hit animation plays.
		$"../Player".get_child(0).attack()
		await get_tree().create_timer(0.5).timeout
		$"../Enemy".get_child(0).hit(tempDic[extra_arg_0]["Damage"])
		$"../Action".text = "Your " + str(Game.selectedMonsters[get_parent().selected]["Name"]) + " attacked for " + str(tempDic[0]["Damage"]) + " hp"
		get_parent().MonsterTurn()
