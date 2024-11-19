extends AnimatedSprite2D

var Health = 20
var level = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("skeleton_idle")
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
	play("skeleton_hit")
	await wait(0.8)
	if Health <= 0:
		play("skeleton_death")
	else:
		play("skeleton_idle")
		
func attack() -> void:
	play("skeleton_attack")
	await wait(0.9)
	play("skeleton_idle")

# Utility function to create a delay
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
