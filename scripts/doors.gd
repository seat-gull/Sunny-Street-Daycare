extends Area2D

@export var textbox: CanvasLayer
@export var tile_map: TileMapLayer

@export var door_cell: Vector2i=Vector2i(0,6)
@export var source_id: int = 1
@export var open_door_coords: Vector2i=Vector2i(4,8)

@export var locked: bool = true

var player_nearby: bool = false
var door_open: bool = false

func _ready() -> void:
	body_entered.connect(entered)
	body_exited.connect(exited)

func _process(delta: float) -> void:
	if player_nearby and not door_open:
		if Input.is_action_just_pressed("interact"):
			if locked:
				textbox.animate_text("The door is locked.","n")
			else:
				open_door()

func entered(body: Node2D) -> void:
	if body.is_in_group("player") and not door_open:
		player_nearby = true
		textbox.animate_text("Press E to open","n")

func exited(body: Node2D) -> void:
	if body.is_in_group("player") and not door_open:
		player_nearby = false
		textbox.hide_textbox()
		
func open_door() -> void:
	door_open = true
	tile_map.set_cell(door_cell,source_id,open_door_coords)
	textbox.hide_textbox()
