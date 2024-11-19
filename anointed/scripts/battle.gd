extends CanvasLayer

var monsterTest = preload("res://Monsters/skeleton.tscn")
# Called when the node enters the scene tree for the first time.

var selected = 0

func _ready() -> void:
		# Show enemy monster
	var montemp = monsterTest.instantiate()
	$Enemy.add_child(montemp)
	montemp.flip_h = true
	$UI/GainedXP.hide()
	$UI/Fight_Menu.hide()
	$UI/Switch_Menu.hide()
	$UI/Menu.hide()
	$UI/Menu/GridContainer/Fight.grab_focus()
	
	# Wait a second to add a little more drama of loading into a battle.
	await get_tree().create_timer(1.0).timeout
	
	# Show player monster
	for i in Game.selectedMonsters:
		var monTemp = Game.selectedMonsters[i]["Scene"].instantiate()
		monTemp.name = Game.selectedMonsters[i]["Name"]
		monTemp.hide()
		$Player.add_child(monTemp)
	$Player.get_child(selected).show()
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
	
	var damage = randi_range(10, 15)
	
	# Perhaps appear to wait
	$Action.text = "Enemy is thinking.."
	await get_tree().create_timer(1).timeout
	
	if $Enemy.get_child(0).Health <= 0:
		Game.addExp(100)
		get_tree().change_scene_to_file("res://scenes/world.tscn")
		
	$Enemy.get_child(0).attack()
	$Player.get_child(selected).hit(damage)
	
	# TODO: Add a function that randomly chooses an attack out of the 3 choices and uses that for the print out for Action.text
	$Action.text = "Enemy " + $Enemy.get_child(0).name + " attacked using SLASH for " + str(damage) + " hp"
	Game.selectedMonsters[selected]["Health"] -= damage
	await get_tree().create_timer(1).timeout
	$UI/Menu/GridContainer/Fight.grab_focus()
	$UI/Menu.show()
	


func _on_monster_pressed(extra_arg_0: int) -> void:
	$Player.get_child(selected).hide()
	selected = extra_arg_0
	$Player.get_child(selected).show()
