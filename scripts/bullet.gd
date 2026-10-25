
extends Node2D

const speed = 100

@onready var sprite: Sprite2D = $Sprite2D


func set_bullet_texture(new_texture: Texture2D) -> void:
	sprite.texture = new_texture


func _process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_kill_timer_timeout() -> void:
	queue_free()
