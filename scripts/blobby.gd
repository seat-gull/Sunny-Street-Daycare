extends AnimatableBody2D

const bullet_scene = preload("res://scenes/bullet.tscn")

@onready var shoot_timer = $ShootTimer

@export var shooter_timer_wait_time: float = 0.5
@export var step_height: float = 20.0
@export var start_height: float = -30.0
@export var left_angle_spread: float = 20.0

var height_pattern = [0, 0.5, 1, 1.5, 1, 0.5,0]
var shot_count: int = 0

@export var bullet_textures: Array[Texture2D] = []

func _ready() -> void:
	shoot_timer.wait_time = shooter_timer_wait_time
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	shoot_timer.start()


func _on_shoot_timer_timeout() -> void:
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)

	var height_step = height_pattern[shot_count]
	bullet.global_position = global_position + Vector2(0,start_height + height_step * step_height)

	bullet.global_rotation = deg_to_rad(
		180.0 + randf_range(-left_angle_spread, left_angle_spread))

	if bullet_textures.size() > 0:
		bullet.set_bullet_texture(bullet_textures.pick_random())

	shot_count = (shot_count + 1) % height_pattern.size()
