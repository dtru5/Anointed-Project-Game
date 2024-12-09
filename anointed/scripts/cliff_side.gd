extends Node2D

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
		if Global.current_scene == "cliff_side":
			Global.finish_changeScene()
			get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_dev_chest_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		body.is_near_enemy = true
