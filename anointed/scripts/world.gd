extends Node2D

# Called when the node enters the scene tree for the first time.
# Also checks to see where player is coming from (i.e. exiting a fight, exit cliffside)
func _ready() -> void:
	$Path2D/PathFollow2D/test_enemy/AnimatedSprite2D.scale.x = 1.0
	$Path2D/PathFollow2D/test_enemy/AnimatedSprite2D.scale.y = 1.0
	$Path2D/PathFollow2D/test_enemy/Label.hide()
	if Global.game_first_loadin == true and Global.game_exit_fight == false:
		$player.position.x = Global.player_start_posx
		$player.position.y = Global.player_start_posy
		
	elif Global.game_exit_fight == true:
		if Game.selectedBossName == "first_boss":
			$player.position.x = Global.player_first_fight_posx
			$player.position.y = Global.player_first_fight_posy
		elif Game.selectedBossName == "mushroom":
			$player.position.x = Global.player_mushroom_fight_posx - 30
			$player.position.y = Global.player_mushroom_fight_posy
		Global.game_exit_fight = false
		
	elif Global.change_to_cliffside == true:
		$player.position.x = Global.player_exit_cliffside_posx
		$player.position.y = Global.player_exit_cliffside_posy
		Global.change_to_cliffside = false
		
	elif Global.change_to_forest == true:
		$player.position.x = Global.player_exit_forest_posx
		$player.position.y = Global.player_exit_forest_posy
		Global.change_to_forest = false
		
	if Global.first_enemy_defeated == true:
		$Path2D/PathFollow2D/test_enemy.queue_free()
		
	if Global.mushroom_defeated == true:
		$Mushroom.queue_free()
		$Mushroom_Fight/CollisionShape2D.disabled = true
	else:
		$Mushroom.position.x = 454
		$Mushroom.position.y = 113

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_scene()

# When player enters the area to move to cliff side scene
func _on_cliffside_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.transition_scene = true
		Global.change_to_cliffside = true

# Not super useful function, but acts as a just in case if the player doesn't
# change scenes
func _on_cliffside_transition_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		Global.transition_scene = false


func _on_forest_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.change_to_forest = true
		Global.transition_scene = true
		
# Function to change scenes
func change_scene():
	if Global.transition_scene == true:
		# Load in cliffside
		if Global.current_scene == "world" and Global.change_to_cliffside == true:
			get_tree().change_scene_to_file("res://scenes/cliff_side.tscn")
			Global.game_first_loadin = false	
			Global.finish_changeScene()
			
		# Load in forest
		elif Global.current_scene == "world" and Global.change_to_forest == true:
			get_tree().change_scene_to_file("res://scenes/forest.tscn")
			Global.game_first_loadin = false	
			Global.finish_changeScene()


func _on_mushroom_fight_body_entered(body: Node2D) -> void:
	if body.name == "player":
		Global.player_mushroom_fight_posx = body.global_position.x
		Global.player_mushroom_fight_posy = body.global_position.y
		Global.game_exit_fight = true
		Game.selectedBoss = Game.mushroom
		Game.selectedBossName = "mushroom"
		get_tree().change_scene_to_file("res://scenes/battle.tscn")
