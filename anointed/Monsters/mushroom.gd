extends AnimatedSprite2D

var Health = 20
var level = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("mushroom_idle")
	# run_test()

# Function to test hit with delays
func run_test() -> void:
	await wait(2.0)  # Wait for 1 second
	hit(10)
	await wait(2.0)  # Wait for another second
	hit(10)

# Function to apply damage and handle animations
func hit(damage: int) -> void:
	Health -= damage
	await wait(0.7)
	play("mushroom_hit")
	await wait(0.5)
	if Health <= 0:
		play("mushroom_death")
	else:
		play("mushroom_idle")
		
func attack() -> void:
	play("mushroom_run")
	$AnimationPlayer.play("walk")
	await wait(1.0)
	play("mushroom_attack")
	await wait(0.9)
	play("mushroom_run")
	$AnimationPlayer.play("walk_back")
	await wait(1.0)
	play("mushroom_idle")
	
func attack_back() -> void:
	play("mushroom_run")
	$AnimationPlayer.play("monster_walk")
	await wait(1.0)
	play("mushroom_attack")
	await wait(0.9)
	play("mushroom_run")
	$AnimationPlayer.play("monster_walk_back")
	await wait(1.0)
	play("mushroom_idle")

# Utility function to create a delay
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
