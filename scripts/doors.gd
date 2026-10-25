extends Area2D

@export var textbox: CanvasLayer

var player_nearby: bool = false
var door_open: bool = false

func _ready() -> void:
	body_entered.connect(entered)
	body_exited.connect(exited)

func _process(delta: float) -> void:
	if player_nearby and not door_open:
		if Input.is_action_just_pressed("interact"):
			textbox.animate_text("The door is locked.","n")

func entered(body: Node2D) -> void:
	if body.is_in_group("player") and not door_open:
		player_nearby = true
		textbox.animate_text("Press E to open door","n")

func exited(body: Node2D) -> void:
	if body.is_in_group("player") and not door_open:
		player_nearby = false
		textbox.hide_textbox()
		
