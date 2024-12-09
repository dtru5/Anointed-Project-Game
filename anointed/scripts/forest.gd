extends Node2D

func _ready() -> void:
	Global.current_scene = "forest"
	if Global.game_exit_fight == true and Game.selectedBossName == "goblin":
		$player.position.x = Global.player_goblin_fight_posx - 30
		$player.position.y = Global.player_goblin_fight_posy
		Global.game_exit_fight = false
	if Global.game_exit_fight == true and Game.selectedBossName == "final_boss":
		$player.position.x = Global.player_final_boss_fight_posx
		$player.position.y = Global.player_final_boss_fight_posy - 30
		Global.game_exit_fight = false
	$Goblin.position.x = 360
	$Goblin.position.y = 168
	$final_boss.position.x = 533
	$final_boss.position.y = 452
	if Global.goblin_defeated == true:
		$Goblin.queue_free()
		$goblin_fight/CollisionShape2D.disabled = true
	if Global.final_boss_defeated == true:
		$final_boss.queue_free()
		$boss_fight/CollisionShape2D.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_scene()

func _on_world_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.transition_scene = true
			


func _on_world_transition_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		Global.transition_scene = false

func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "forest":
			Global.finish_changeScene()
			get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_goblin_fight_body_entered(body: Node2D) -> void:
	if body.name == "player":
		Global.player_goblin_fight_posx = body.global_position.x
		Global.player_goblin_fight_posy = body.global_position.y
		Global.game_exit_fight = true
		Game.selectedBoss = Game.goblin
		Game.selectedBossName = "goblin"
		get_tree().change_scene_to_file("res://scenes/battle.tscn")


func _on_boss_fight_body_entered(body: Node2D) -> void:
	if body.name == "player":
		Global.player_final_boss_fight_posx = body.global_position.x
		Global.player_final_boss_fight_posy = body.global_position.y
		Global.game_exit_fight = true
		Game.selectedBoss = Game.finalBoss
		Game.selectedBossName = "final_boss"
		get_tree().change_scene_to_file("res://scenes/battle.tscn")
