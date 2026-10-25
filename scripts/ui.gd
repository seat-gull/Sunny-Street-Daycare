extends Control

@onready var health_bar = $HealthBar 
@export var player: CharacterBody2D

func _process(delta: float) -> void:
	if player:
		health_bar.max_value = player.max_health
		health_bar.value = player.health
