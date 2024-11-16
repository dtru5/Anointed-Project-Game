extends Node2D

# Called when the node enters the scene tree for the first time.
# Also checks to see where player is coming from (i.e. exiting a fight, exit cliffside)
func _ready() -> void:
	print(Global.current_scene)
	if Global.game_first_loadin == true and Global.game_exit_fight == false:
		$player.position.x = Global.player_start_posx
		$player.position.y = Global.player_start_posy
		
	elif Global.game_exit_fight == true:
		$player.position.x = Global.player_first_fight_posx
		$player.position.y = Global.player_first_fight_posy
		Global.game_exit_fight = false
		
	elif Global.change_to_cliffside == true:
		$player.position.x = Global.player_exit_cliffside_posx
		$player.position.y = Global.player_exit_cliffside_posy
		Global.change_to_cliffside = false
		
	elif Global.change_to_forest == true:
		$player.position.x = Global.player_exit_forest_posx
		$player.position.y = Global.player_exit_forest_posy
		Global.change_to_forest = false

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
