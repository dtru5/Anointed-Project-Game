extends Node

var current_scene = "world"
var transition_scene = false

var player_exit_cliffside_posx = 254
var player_exit_cliffside_posy = 0
var player_start_posx = 14
var player_start_posy = 42

var game_first_loadin = true

func finish_changeScene():
	if transition_scene == true:
		transition_scene = false
		print("ooooo\n")
		if current_scene == "world":
			current_scene = "cliff_side"
		else:
			current_scene = "world"
