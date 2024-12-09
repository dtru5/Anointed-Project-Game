extends AnimatedSprite2D

@onready var sword_swing: AudioStreamPlayer2D = $sword_swing
@onready var sfx_skeleton_hit: AudioStreamPlayer2D = $sfx_skeleton_hit
@onready var sfx_skeleton_run: AudioStreamPlayer2D = $sfx_skeleton_run

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
	await wait(0.7)
	play("skeleton_hit")
	sfx_skeleton_hit.play()
	await wait(0.8)
	if Health <= 0:
		play("skeleton_death")
	else:
		play("skeleton_idle")
		
func attack() -> void:
	play("skeleton_walk")
	$AnimationPlayer.play("walk")
	sfx_skeleton_run.play()
	await wait(1.0)
	sfx_skeleton_run.stop()
	play("skeleton_attack")
	await wait(0.5)
	sword_swing.play()
	await wait(0.4)
	play("skeleton_walk")
	$AnimationPlayer.play("walk_back")
	sfx_skeleton_run.play()
	await wait(1.0)
	sfx_skeleton_run.stop()
	play("skeleton_idle")
	
func attack_back() -> void:
	play("skeleton_walk")
	$AnimationPlayer.play("monster_walk")
	sfx_skeleton_run.play()
	await wait(1.0)
	sfx_skeleton_run.stop()
	play("skeleton_attack")
	await wait(0.5)
	sword_swing.play()
	await wait(0.4)
	play("skeleton_walk")
	$AnimationPlayer.play("monster_walk_back")
	sfx_skeleton_run.play()
	await wait(1.0)
	sfx_skeleton_run.stop()
	play("skeleton_idle")

	
# Utility function to create a delay
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
