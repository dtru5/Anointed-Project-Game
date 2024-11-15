extends CanvasLayer

@onready var player_sprite: AnimatedSprite2D = $ui/player_monster
@onready var enemy_sprite: Sprite2D = $ui/enemy_monster

var icon = preload("res://art/icon.svg")
var skeleton_scene = preload("res://Monsters/skeleton.tscn")

func _ready() -> void:
	# Create an instance of the skeleton scene
	var skeleton_instance = skeleton_scene.instantiate()
	# Replace player_sprite in the scene
	$ui.remove_child(player_sprite)          # Remove the existing player_sprite node from the UI
	$ui.add_child(skeleton_instance)          # Add the skeleton instance to the UI node
	player_sprite = skeleton_instance         # Update player_sprite reference to the new instance
	player_sprite.global_position.x = 100
	player_sprite.global_position.y = 380

	# Set up the enemy sprite as before
	enemy_sprite.texture = icon
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("escape"):
		get_tree().change_scene_to_file("res://scenes/world.tscn")
