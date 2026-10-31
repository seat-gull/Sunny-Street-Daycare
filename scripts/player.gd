extends CharacterBody2D

@onready var sprite = $sprite
@onready var arrow = $"blobby pointer"
@onready var dash = $dash
@onready var pencil = $pencil

@export var textbox: CanvasLayer
@export var movement_speed : float = 150
@export var hotbar: Control
@export var blobby: Node2D

var direction : Vector2 = Vector2(4, 4)
var movement_locked: bool = false
var start_position: Vector2

const dashspeed = 800
const dashlength = .1

var max_health: int = 100
var health: int = 100

var key_is_in_inv: bool = false

func _ready() -> void:
	start_position = global_position
	pencil.visible = true
	arrow.position = Vector2(30, -30)
	hotbar.slotSelected.connect(_on_slot_selected)

func _physics_process(delta:float) -> void:
	if movement_locked:
		velocity = Vector2.ZERO
		sprite.animation = "idle"
		move_and_slide()
		return

	if blobby.has_triggered:
		arrow.show()
		arrow.look_at(blobby.global_position)
	else:
		arrow.hide()

	direction.x = Input.get_axis("move_left","move_right")
	direction.y = Input.get_axis("move_up","move_down")
	direction = direction.normalized()
	
	if Input.is_action_just_pressed("dash") and not dash.is_dashing():
		dash.start_dash(dashlength)
	var speed = dashspeed if dash.is_dashing() else movement_speed
	
	if Input.is_action_just_pressed("attack") and pencil.visible:
		pencil.attack()
	
	#flipping 
	if direction.x > 0:
		sprite.flip_h = false
		pencil.scale.x = 1
		pencil.position.x = 0
	elif direction.x < 0:
		sprite.flip_h = true
		pencil.scale.x = -1
		pencil.position.x = 10
	
	if dash.is_dashing():
		sprite.animation = "dash"
		velocity = direction * dashspeed
		
	elif direction != Vector2.ZERO:
		velocity = direction * movement_speed
		if sprite.animation != "walk":
			sprite.animation = "walk"
	else: 
		velocity = velocity.move_toward(Vector2.ZERO,speed)
		if sprite.animation != "idle":
			sprite.animation = "idle"
		
	move_and_slide()
	
func _on_slot_selected(slotNumber):
	pencil.visible = (slotNumber == 1)
	
func take_damage(amount: int) -> void:
	health = clampi(health - amount, 0, max_health)

	if health <= 0:
		die()

func die() -> void:
	queue_free()
	get_tree().change_scene_to_file("res://scenes/try_again.tscn")
	


	
	
