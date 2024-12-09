extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Skeleton.position.x = 473
	$Skeleton.position.y = 140
	Global.can_move = false
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "start")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.dialogue_skeleton_ended == true:
		Game.selectedBoss = Game.skeleton
		Game.selectedBossName = "first_skeleton"
		get_tree().change_scene_to_file("res://scenes/battle.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		Global.can_move = false
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/first_skeleton.dialogue"), "start")
