extends CanvasLayer

@onready var player_sprite: Sprite2D = $ui/player_monster
@onready var enemy_sprite: Sprite2D = $ui/enemy_monster

var icon = preload("res://art/icon.svg")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_sprite.texture = icon
	enemy_sprite.texture = icon

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("escape"):
		get_tree().change_scene_to_file("res://scenes/world.tscn")
