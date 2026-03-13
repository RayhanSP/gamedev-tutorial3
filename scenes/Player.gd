extends CharacterBody2D

@export var gravity = 1000.0
@export var walk_speed = 200
@export var jump_speed = -300
@export var max_jumps = 2

# Variabel baru untuk Dash
@export var dash_speed = 500      
@export var dash_duration = 0.2   

@onready var anim = $AnimatedSprite2D 

var jump_count = 0 
var is_dashing = false
var dash_timer = 0.0
var current_dash_anim = "" 

func _physics_process(delta):

	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false 
	else:
		velocity.y += delta * gravity

	if is_on_floor():
		jump_count = 0

	
	if Input.is_action_just_pressed("dash") and not is_dashing:
		is_dashing = true
		dash_timer = dash_duration
		current_dash_anim = ["dash", "slide"].pick_random() 
	
		var dir = -1 if anim.flip_h else 1
		velocity.x = dir * dash_speed
		velocity.y = 0 

	if Input.is_action_just_pressed('ui_up') and not is_dashing and not Input.is_action_pressed("crouch"):
		if is_on_floor() or jump_count < max_jumps:
			velocity.y = jump_speed
			jump_count += 1
			$JumpSFX.play()

	if not is_dashing:
		if Input.is_action_pressed("crouch") and is_on_floor():
			velocity.x = 0
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -walk_speed
			anim.flip_h = true   
		elif Input.is_action_pressed("ui_right"):
			velocity.x = walk_speed
			anim.flip_h = false  
		else:
			velocity.x = 0

	#Animasi
	if is_dashing:
		anim.play(current_dash_anim) 
	elif not is_on_floor():
		if jump_count == 2:
			anim.play("doublejump")

		else:
			anim.play("jump")
	
	elif Input.is_action_pressed("crouch"):
		anim.play("crouch")
	elif velocity.x != 0:
		anim.play("run")
	else:
		anim.play("idle")

	# Eksekusi pergerakan
	move_and_slide()
