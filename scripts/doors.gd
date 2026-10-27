extends Area2D

@export var textbox: CanvasLayer

var player_nearby: bool = false
var door_open: bool = false
var player_ref: Node2D = null


func _ready() -> void:
	body_entered.connect(entered)
	body_exited.connect(exited)

func _process(delta: float) -> void:
	if player_nearby and not door_open and player_ref:
		if Input.is_action_just_pressed("interact"):
			if player_ref.key_is_in_inv:
				textbox.animate_text("Door opens","n")
			else:
				textbox.animate_text("The door is locked. Try finding a key...","n")

func entered(body: Node2D) -> void:
	if body.is_in_group("player") and not door_open:
		player_nearby = true
		player_ref = body
		textbox.animate_text("Press E to open door","n")

func exited(body: Node2D) -> void:
	if body.is_in_group("player") and not door_open:
		player_nearby = false
		player_ref = null
		textbox.hide_textbox()
		
