extends Control

var maxHealth
var remaining_health
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	maxHealth = $"../Enemy".get_child(get_parent().enemy_selected).Health
	$HPbar.max_value = $"../Enemy".get_child(get_parent().enemy_selected).Health
	$HPbar.value = $"../Enemy".get_child(get_parent().enemy_selected).Health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	remaining_health = $"../Enemy".get_child(get_parent().enemy_selected).Health
	if remaining_health < 0:
		remaining_health = 0
	$HPbar.value = remaining_health
	$HpText.text = str(remaining_health) + " / " + str(maxHealth)
	$Info.text = str(Game.selectedBoss[get_parent().enemy_selected]["Name"]) + " lvl: " + str(Game.selectedBoss[get_parent().enemy_selected]["Level"])
