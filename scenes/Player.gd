extends CharacterBody2D

@export var gravity = 200.0
@export var walk_speed = 200
@export var jump_speed = -300
@export var max_jumps = 2

@onready var anim = $AnimatedSprite2D 

var jump_count = 0 

func _physics_process(delta):
	# 1. Terapkan gravitasi
	velocity.y += delta * gravity

	# Reset hitungan loncat kalau karakter menginjak lantai
	if is_on_floor():
		jump_count = 0

	# 2. Logika Loncat & Double Jump
	if Input.is_action_just_pressed('ui_up'):
		if is_on_floor() or jump_count < max_jumps:
			velocity.y = jump_speed
			jump_count += 1

	# 3. Logika Jalan & Balik Badan (Flip)
	if Input.is_action_pressed("ui_left"):
		velocity.x = -walk_speed
		anim.flip_h = true   
	elif Input.is_action_pressed("ui_right"):
		velocity.x = walk_speed
		anim.flip_h = false  
	else:
		velocity.x = 0

	# 4. Logika Animasi
	if not is_on_floor():
		# Cek apakah ini loncatan kedua (double jump)
		if jump_count == 2:
			anim.play("doublejump")
		else:
			anim.play("jump") # Loncatan pertama atau sekadar jatuh
	elif velocity.x != 0:
		anim.play("run")
	else:
		anim.play("idle")

	# Eksekusi pergerakan
	move_and_slide()
