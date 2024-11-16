extends Node

var current_scene = "world"
var transition_scene = false

# Player position when exiting from cliffside
var player_exit_cliffside_posx = 254
var player_exit_cliffside_posy = 0

# Player position when exiting from forest
var player_exit_forest_posx = 523
var player_exit_forest_posy = 220

# Player starting position when first loading into main scene
var player_start_posx = 14
var player_start_posy = 42

# Player position when they first enter a fight so they can return to this location afterwards
var player_first_fight_posx
var player_first_fight_posy

var player_monsters: Array = []

var game_first_loadin = true
var game_exit_fight = false

# Variables to tell what scene we are transitioning to
var change_to_cliffside = false
var change_to_forest = false

func finish_changeScene():
	if transition_scene == true:
		transition_scene = false
		# Set current scene to cliffside 
		if current_scene == "world" and change_to_cliffside == true:
			current_scene = "cliff_side"
		# Set current scene to forest
		elif current_scene == "world" and change_to_forest == true:
			current_scene = "forest"
		else:
			current_scene = "world"
