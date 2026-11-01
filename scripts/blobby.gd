extends AnimatableBody2D

const bullet_scene = preload("res://scenes/bullet.tscn")

@onready var sprite = $animation
@onready var shoot_timer = $ShootTimer
@onready var trigger_area: Area2D = $TriggerArea
@export var textbox: CanvasLayer
@export var player: CharacterBody2D
@onready var redkey = $redkey
@onready var healthbar = $HealthBar

var shooter_timer_wait_time: float = 0.35
var teleport_min: Vector2 = Vector2(50, 50)
var teleport_max: Vector2 = Vector2(650, 0)

var has_triggered: bool = false

var maxhealth = 50
var health = 50
var next_teleport_health = 40
var isDead = false

@export var bullet_textures: Array[Texture2D] = []

func _ready() -> void:
	redkey.textbox = textbox
	redkey.monitoring = false
	redkey.hide()
	shoot_timer.stop()
	shoot_timer.wait_time = shooter_timer_wait_time
	trigger_area.body_entered.connect(_on_player_entered)
	healthbar.init_health(maxhealth)

func _process(delta: float) -> void:
	if has_triggered and !isDead:
		sprite.look_at(player.global_position)
		sprite.rotation += PI

#detect player enter boss area
func _on_player_entered(body: Node2D) -> void:
	if has_triggered:
		return

	if not body.is_in_group("player"):
		return

	has_triggered = true

	trigger_area.set_deferred("monitoring", false)
	body.movement_locked = true
	textbox.animate_text("Thanks for coming to daycare! You'll be a delicious snack!", "Blobby")
	await get_tree().create_timer(3.5).timeout
	textbox.hide_textbox()
	
	if is_instance_valid(body):
		body.movement_locked = false
	shoot_timer.start()

func _on_shoot_timer_timeout() -> void:

	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	
	bullet.global_position = global_position
	bullet.global_rotation = bullet.global_position.direction_to(player.global_position).angle()
	
	var visual_angle = randf_range(0, TAU)
	bullet.set_sprite_rotation(visual_angle)

	if bullet_textures.size() > 0:
		var texture = bullet_textures.pick_random()
		bullet.set_bullet_texture(texture)

func takeDamage(amount: int) -> void:
	health = max(health - amount, 0)
	healthbar._set_health(health)
	print("Blobby health: ", health)
	
	if health <= 0:
		die()
	
	if health <= next_teleport_health:
		teleport()
		next_teleport_health -= 10

func teleport() -> void:
	global_position = Vector2(randf_range(teleport_min.x, teleport_max.x),randf_range(teleport_min.y, teleport_max.y))

func die() -> void:
	if isDead:
		return
		
	isDead = true
	shoot_timer.stop()
	trigger_area.set_deferred("monitoring", false)
	
	textbox.animate_text("blehhhh", "Blobby")
	sprite.play("dying")
	await sprite.animation_finished
	remove_child(redkey)
	textbox.hide_textbox()
	get_tree().current_scene.add_child(redkey)
	redkey.global_position = Vector2(global_position.x+6,global_position.y)
	
	redkey.show()
	redkey.set_deferred("monitoring", true)
	healthbar.hide()
	collision_layer = false
	
