extends Area2D

@export var textbox: CanvasLayer
@export var tilemap: TileMapLayer
#

var player_nearby: bool = false
var door_open: bool = false
var player_ref: Node2D = null
var current_door: String = ""

func _ready() -> void:
	body_shape_entered.connect(_on_body_shape_entered)
	body_shape_exited.connect(_on_body_shape_exited)

func _process(delta: float) -> void:
	if player_nearby and not door_open and player_ref:
		if Input.is_action_just_pressed("interact"):
			if player_ref.key_is_in_inv:
				if current_door == "red door":
					door_open = true
					open_red_door()
				else:
					textbox.animate_text("This key doesn't fit","n")
			else:
				textbox.animate_text("The door is locked. Try finding a key...","n")

func open_red_door() -> void:
	if tilemap:
		tilemap.set_cell(Vector2i(34, 12),1,Vector2i(6,9))
		tilemap.set_cell(Vector2i(34, 11),1,Vector2i(6,8))
		textbox.animate_text("It opens!","n")
		await get_tree().create_timer(1).timeout
		textbox.hide_textbox()
	var red_door_shape = get_node_or_null("red door")
	if red_door_shape:
		red_door_shape.set_deferred("disabled",true)


func _on_body_shape_entered(
	_body_rid: RID,
	body: Node2D,
	body_shape_index: int,
	_local_shape_index: int
) -> void:
	if body.is_in_group("player") and not door_open:
		player_nearby = true
		player_ref = body
		
		var owner_id = shape_find_owner(_local_shape_index)
		var shape_owner = shape_owner_get_owner(owner_id)
		current_door = shape_owner.name
		
		textbox.animate_text("Press E to open door","n")

func _on_body_shape_exited(
	_body_rid: RID,
	body: Node2D,
	_body_shape_index: int,
	_local_shape_index: int
) -> void:
	if body.is_in_group("player") and not door_open:
		player_nearby = false
		player_ref = null
		current_door = ""
		textbox.hide_textbox()



func _on_note_pressed() -> void:
	textbox.animate_text("HELP ME","n")
	await get_tree().create_timer(2.5).timeout
	textbox.hide_textbox()


func _on_note_2_pressed() -> void:
	textbox.animate_text("AHHHHHH!","n")
	await get_tree().create_timer(2.5).timeout
	textbox.hide_textbox()
