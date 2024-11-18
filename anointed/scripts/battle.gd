extends CanvasLayer

var monsterTest = preload("res://Monsters/skeleton.tscn")
# Called when the node enters the scene tree for the first time.

var selected = 0

func _ready() -> void:
	$UI/Fight_Menu.hide()
	$UI/Switch_Menu.hide()
	$UI/Menu.hide()
	$UI/Menu/GridContainer/Fight.grab_focus()
	
	# Wait a second to add a little more drama of loading into a battle.
	await get_tree().create_timer(2).timeout
	
	# Show enemy monster
	var montemp = monsterTest.instantiate()
	montemp.flip_h = true
	$Enemy.add_child(montemp)
	
	# Show player monster
	for i in Game.selectedMonsters:
		var monTemp = Game.selectedMonsters[i]["Scene"].instantiate()
		monTemp.name = Game.selectedMonsters[i]["Name"]
		monTemp.hide()
		$Player.add_child(monTemp)
	$Player.get_child(0).show()
	$UI/Menu.show()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_capture_pressed() -> void:
	pass # Replace with function body.

func _on_attack_pressed(extra_arg_0: int) -> void:
	pass # Replace with function body.
	
func MonsterTurn() -> void:
	pass
