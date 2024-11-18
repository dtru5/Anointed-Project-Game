extends Control

var maxHealth

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	maxHealth = $"../Enemy".get_child(0).Health
	$HPbar.max_value = $"../Enemy".get_child(0).Health
	$HPbar.value = $"../Enemy".get_child(0).Health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$HPbar.value = $"../Enemy".get_child(0).Health
	$HpText.text = str($"../Enemy".get_child(0).Health) + " / " + str(maxHealth)
	$Info.text = str($"../Enemy".get_child(0).name) + " lvl: " + str($"../Enemy".get_child(0).level)
