extends Control

@onready var health_bar: ProgressBar = $HealthBar
@export var player: CharacterBody2D


func _ready() -> void:
	if player:
		health_bar.max_value = player.max_health
		health_bar.value = player.health
func _process(_delta: float) -> void:
	if not is_instance_valid(player):
		return
	health_bar.max_value = player.max_health
	health_bar.value = player.health
