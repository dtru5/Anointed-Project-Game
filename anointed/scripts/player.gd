extends CharacterBody2D

@onready var walking_sfx: AudioStreamPlayer2D = $walking_sfx

const speed = 100
var current_direction = "none"
var is_near_enemy = false
var enemy_reference = null

func _ready() -> void:
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta: float) -> void:
	if Global.can_move == true:
		player_movement(delta)
	else:
		$AnimatedSprite2D.play("front_idle")
	# Check if the 'E' key is pressed and player is near the enemy
	if Input.is_action_just_pressed("interact") and is_near_enemy:
		Game.addExp(100)
		$"../AudioStreamPlayer2D".play()
	current_camera()
	
func player_movement(delta):
	var direction_vector = Vector2.ZERO

	# Capture input for all directions
	if Input.is_action_pressed("move_right"):
		direction_vector.x += 1
	if Input.is_action_pressed("move_left"):
		direction_vector.x -= 1
	if Input.is_action_pressed("move_down"):
		direction_vector.y += 1
	if Input.is_action_pressed("move_up"):
		direction_vector.y -= 1

	# Normalize direction vector to avoid faster diagonal movement
	direction_vector = direction_vector.normalized()

	# Adjust speed if shift is pressed
	var current_speed = speed
	if Input.is_action_pressed("sprint"):
		current_speed *= 1.5  # Sprint multiplier (adjust as needed)

	# Set the velocity based on direction and speed
	velocity = direction_vector * current_speed
	
		# Control walking audio
	if direction_vector != Vector2.ZERO:
		if not walking_sfx.playing:
			walking_sfx.play()
	else:
		walking_sfx.stop()

	# Play appropriate animation
	if direction_vector != Vector2.ZERO:
		update_direction_and_animation(direction_vector)
	else:
		play_animation(0)  # Idle animation

	move_and_slide()


func update_direction_and_animation(direction_vector):
	if direction_vector.x > 0:
		current_direction = "right"
	elif direction_vector.x < 0:
		current_direction = "left"
	elif direction_vector.y > 0:
		current_direction = "down"
	elif direction_vector.y < 0:
		current_direction = "up"

	play_animation(1)

func play_animation(movement):
	var direction = current_direction
	var animation = $AnimatedSprite2D

	if direction == "right":
		animation.flip_h = false
		if movement == 1:
			animation.play("side_walk")
		elif movement == 0:
			animation.play("side_idle")
			
	elif direction == "left":
		animation.flip_h = true
		if movement == 1:
			animation.play("side_walk")
		elif movement == 0:
			animation.play("side_idle")
			
	elif direction == "down":
		if movement == 1:
			animation.play("front_walk")
		elif movement == 0:
			animation.play("front_idle")
			
	elif direction == "up":
		if movement == 1:
			animation.play("back_walk")
		elif movement == 0:
			animation.play("back_idle")


# Handle the start of the battle
func start_battle():
	Global.player_first_fight_posx = global_position.x
	Global.player_first_fight_posy = global_position.y
	Global.game_exit_fight = true
	get_tree().change_scene_to_file("res://scenes/battle.tscn")  # Switch to battle scene
	
func player():
	pass
	
func current_camera():
	# Set camera to be world camera 
	if Global.current_scene == "world":
		$world_camera.enabled = true
		$cliff_side_camera.enabled = false
		$forest_camera.enabled = false
	# Set camera to be cliff side camera
	elif Global.current_scene == "cliff_side":
		$world_camera.enabled = false
		$cliff_side_camera.enabled = true
		$forest_camera.enabled = false
	# Set camera to be forest camera
	elif Global.current_scene == "forest":
		$world_camera.enabled = false
		$cliff_side_camera.enabled = false
		$forest_camera.enabled = true
