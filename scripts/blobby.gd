extends AnimatableBody2D

const bullet_scene = preload("res://scenes/bullet.tscn")

@onready var shoot_timer = $ShootTimer
@onready var trigger_area: Area2D = $TriggerArea
@export var textbox: CanvasLayer
@export var shooter_timer_wait_time: float = 0.35
@export var start_height: float = -15
@export var angle_spread: float = 5

var height_pattern = [20, 30, 40, 50, 60, 50, 40, 30, 20]
var shot_count: int = 0
var has_triggered: bool = false
var health = 100

@export var bullet_textures: Array[Texture2D] = []

func _ready() -> void:
	shoot_timer.stop()
	shoot_timer.wait_time = shooter_timer_wait_time
	trigger_area.body_entered.connect(_on_player_entered)

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
		
	var height_step = height_pattern[shot_count]
	bullet.global_position = global_position + Vector2(0,start_height + height_step)
	position.y = start_height + height_step

	bullet.global_rotation = deg_to_rad(180.0 + randf_range(-angle_spread,angle_spread))
	
	var visual_angle = randf_range(0, TAU)
	bullet.set_sprite_rotation(visual_angle)


	if bullet_textures.size() > 0:
		var texture = bullet_textures.pick_random()
		bullet.set_bullet_texture(texture)

	shot_count = (shot_count + 1) % height_pattern.size()
