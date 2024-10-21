extends CharacterBody2D

const speed = 100
var current_direction = "none"
var is_near_enemy = false
var enemy_reference = null

func _ready() -> void:
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta: float) -> void:
	player_movement(delta)
	# Check if the 'E' key is pressed and player is near the enemy
	if Input.is_action_just_pressed("interact") and is_near_enemy:
		start_battle()
	
func player_movement(delta):
	if Input.is_action_pressed("move_right"):
		current_direction = "right"
		play_animation(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("move_left"):
		current_direction = "left"
		play_animation(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("move_down"):
		current_direction = "down"
		play_animation(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("move_up"):
		current_direction = "up"
		play_animation(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
	
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
	get_tree().change_scene_to_file("res://scenes/battle_scene.tscn")  # Switch to battle scene
	
#extends CharacterBody2D
#
#const speed = 100
#var current_direction = "none"
#
#func _ready() -> void:
	#$AnimatedSprite2D.play("front_idle")
#
#func _physics_process(delta: float) -> void:
	#player_movement(delta)
#
#func player_movement(delta):
	#var direction_vector = Vector2.ZERO
#
	## Capture input for all directions
	#if Input.is_action_pressed("move_right"):
		#direction_vector.x += 1
	#if Input.is_action_pressed("move_left"):
		#direction_vector.x -= 1
	#if Input.is_action_pressed("move_down"):
		#direction_vector.y += 1
	#if Input.is_action_pressed("move_up"):
		#direction_vector.y -= 1
#
	## Normalize direction vector to avoid faster diagonal movement
	#direction_vector = direction_vector.normalized()
#
	## Set the velocity based on direction and speed
	#velocity = direction_vector * speed
#
	## Play appropriate animation
	#if direction_vector != Vector2.ZERO:
		#update_direction_and_animation(direction_vector)
	#else:
		#play_animation(0)  # Idle animation
#
	#move_and_slide()
#
#func update_direction_and_animation(direction_vector):
	#if direction_vector.x > 0:
		#current_direction = "right"
	#elif direction_vector.x < 0:
		#current_direction = "left"
	#elif direction_vector.y > 0:
		#current_direction = "down"
	#elif direction_vector.y < 0:
		#current_direction = "up"
#
	#play_animation(1)
#
#func play_animation(movement):
	#var direction = current_direction
	#var animation = $AnimatedSprite2D
#
	#if direction == "right":
		#animation.flip_h = false
		#if movement == 1:
			#animation.play("side_walk")
		#elif movement == 0:
			#animation.play("side_idle")
			#
	#elif direction == "left":
		#animation.flip_h = true
		#if movement == 1:
			#animation.play("side_walk")
		#elif movement == 0:
			#animation.play("side_idle")
			#
	#elif direction == "down":
		#if movement == 1:
			#animation.play("front_walk")
		#elif movement == 0:
			#animation.play("front_idle")
			#
	#elif direction == "up":
		#if movement == 1:
			#animation.play("back_walk")
		#elif movement == 0:
			#animation.play("back_idle")
