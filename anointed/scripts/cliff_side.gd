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
			print("blah")
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			Global.finish_changeScene()
