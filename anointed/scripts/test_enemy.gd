extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("yes")
		body.is_near_enemy = true
		body.enemy_reference = self
	

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		body.is_near_enemy = false
		body.enemy_reference = null
