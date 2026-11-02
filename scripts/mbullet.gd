extends Area2D

const speed = 150 
@onready var sprite: Sprite2D = $Sprite2D

var damage: int = 8

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _process(delta): 
	position += transform.x * speed * delta

func _on_kill_timer_timeout() -> void:
		queue_free()

func set_bullet_texture(new_texture: Texture2D) -> void:
	sprite.texture = new_texture

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(damage)
		queue_free()
	if body is TileMapLayer:
		queue_free()
