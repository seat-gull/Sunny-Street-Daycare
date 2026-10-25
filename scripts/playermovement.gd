extends CharacterBody2D

@export var movement_speed : float = 150
var direction : Vector2

@onready var dash = $dash
const dashspeed = 1000
const dashlength = .1

func _physics_process(delta:float) -> void:

	direction.x = Input.get_axis("move_left","move_right")
	direction.y = Input.get_axis("move_up","move_down")
	direction = direction.normalized()
	
	if Input.is_action_just_pressed("dash") and not dash.is_dashing():
		dash.start_dash(dashlength)
	var speed = dashspeed if dash.is_dashing() else movement_speed
	
	#flipping 
	if direction.x > 0:
		$sprite.flip_h = false
	elif direction.x < 0:
		$sprite.flip_h = true
	if dash.is_dashing():
		$sprite.animation = "dash"
		
	if direction != Vector2.ZERO:
		velocity = direction * speed
		if $sprite.animation != "walk":
			$sprite.animation = "walk"
	else: 
		velocity = velocity.move_toward(Vector2.ZERO,speed)
		if $sprite.animation != "idle":
			$sprite.animation = "idle"
	
	
	

		
	move_and_slide()
