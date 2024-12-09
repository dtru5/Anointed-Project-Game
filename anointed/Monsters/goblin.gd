extends AnimatedSprite2D

@onready var sfx_goblin_sword: AudioStreamPlayer2D = $sfx_goblin_sword
@onready var sfx_goblin_run: AudioStreamPlayer2D = $sfx_goblin_run

var Health = 20
var level = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("goblin_idle")
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
	play("goblin_hit")
	await wait(0.5)
	if Health <= 0:
		play("goblin_death")
	else:
		play("goblin_idle")
		
func attack() -> void:
	play("goblin_run")
	$AnimationPlayer.play("walk")
	sfx_goblin_run.play()
	await wait(1.0)
	sfx_goblin_run.stop()
	play("goblin_attack")
	await wait(0.6)
	sfx_goblin_sword.play()
	await wait(0.3)
	play("goblin_run")
	$AnimationPlayer.play("walk_back")
	sfx_goblin_run.play()
	await wait(1.0)
	sfx_goblin_run.stop()
	play("goblin_idle")
	
func attack_back() -> void:
	play("goblin_run")
	$AnimationPlayer.play("monster_walk")
	sfx_goblin_run.play()
	await wait(1.0)
	sfx_goblin_run.stop()
	play("goblin_attack")
	await wait(0.6)
	sfx_goblin_sword.play()
	await wait(0.3)
	play("goblin_run")
	$AnimationPlayer.play("monster_walk_back")
	sfx_goblin_run.play()
	await wait(1.0)
	sfx_goblin_run.stop()
	play("goblin_idle")

# Utility function to create a delay
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
