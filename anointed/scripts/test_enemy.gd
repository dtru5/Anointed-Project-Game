extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		#print("yes")
		#body.is_near_enemy = true
		#body.enemy_reference = self
		#Game.selectedBoss = 0
		#$Label.show()
		Global.player_first_fight_posx = global_position.x
		Global.player_first_fight_posy = global_position.y
		Global.game_exit_fight = true
		get_tree().change_scene_to_file("res://scenes/battle.tscn")  # Switch to battle scene

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		body.is_near_enemy = false
		body.enemy_reference = null
		$Label.hide()
