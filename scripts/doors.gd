extends Area2D

@export var textbox: CanvasLayer
@export var tilemap: TileMapLayer

var player_nearby: bool = false
var redDoorOpen: bool = false
var player_ref: Node2D = null
var current_door: String = ""
var reading_note: bool = false

func _ready() -> void:
	body_shape_entered.connect(_on_body_shape_entered)
	body_shape_exited.connect(_on_body_exited)

func _process(delta: float) -> void:
	if player_nearby and player_ref:
		if Input.is_action_just_pressed("interact"):
			if current_door == "red door" and not redDoorOpen:
				if player_ref.hasRedKey:
					redDoorOpen = true
					open_red_door()
				else:
					textbox.animate_text("The door is locked. Try finding a key...","n")
			elif current_door == "front door" and player_ref.hasRedKey:
				if player_ref.hasGoldKey:
					get_tree().change_scene_to_file("res://scenes/win.tscn")
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
	if body.is_in_group("player"):
		player_nearby = true
		player_ref = body
		
		var owner_id = shape_find_owner(_local_shape_index)
		var shape_owner = shape_owner_get_owner(owner_id)
		current_door = shape_owner.name
		
		textbox.animate_text("Press E to open door","n")

func _on_body_exited(_body_rid: RID,
	body: Node2D,
	_body_shape_index: int,
	_local_shape_index: int
) -> void:
	if body.is_in_group("player"):
		player_nearby = false
		player_ref = null
		current_door = ""
		textbox.hide_textbox()
		
func _on_note_2_pressed() -> void:
	reading_note = true
	textbox.animate_text("i found a kee to open the red dor but Blobby eat it! i am going try to git it bak, wish me luk!","n")
	await get_tree().create_timer(6).timeout
	textbox.hide_textbox()
	reading_note = false

func _on_note_pressed() -> void:
	reading_note = true
	textbox.animate_text("A big sunflower ate my keys to the front door! -The Janitor","n")
	await get_tree().create_timer(4).timeout
	textbox.hide_textbox()
	reading_note = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		textbox.animate_text("Click on the note to read it","n")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") and reading_note == false:
		textbox.hide_textbox()
