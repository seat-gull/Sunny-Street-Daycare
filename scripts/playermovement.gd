extends CharacterBody2D
@export var textbox: CanvasLayer
@export var movement_speed : float = 150
var direction : Vector2 = Vector2(4, 4)
var movement_locked: bool = false
var start_position: Vector2

@onready var dash = $dash
const dashspeed = 800
const dashlength = .1

var max_health: int = 100
var health: int = 100

var key_is_in_inv: bool = false

func _ready() -> void:
	start_position = global_position

func _physics_process(delta:float) -> void:
	if movement_locked:
		velocity = Vector2.ZERO
		$sprite.animation = "idle"
		move_and_slide()
		return
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
		velocity = direction * dashspeed
		
	elif direction != Vector2.ZERO:
		velocity = direction * movement_speed
		if $sprite.animation != "walk":
			$sprite.animation = "walk"
	else: 
		velocity = velocity.move_toward(Vector2.ZERO,speed)
		if $sprite.animation != "idle":
			$sprite.animation = "idle"
		
	move_and_slide()
	
	
func take_damage(amount: int) -> void:
	health = clampi(health - amount, 0, max_health)
	print("Player health: ", health)

	if health <= 0:
		die()

func die() -> void:
	global_position = start_position
	velocity = Vector2.ZERO
	textbox.animate_text("Lil guy died :(, thx for playing tho!", "n")
	queue_free()
