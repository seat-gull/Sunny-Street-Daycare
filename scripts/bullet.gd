extends Area2D

@export var speed: float = 100.0
@export var damage: int = 10

@onready var sprite: Sprite2D = $Sprite2D

func set_bullet_texture(new_texture: Texture2D) -> void:
	sprite.texture = new_texture

func set_sprite_rotation(angle_radians: float) -> void:
	sprite.rotation = angle_radians
	
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	global_position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(damage)
		queue_free()
