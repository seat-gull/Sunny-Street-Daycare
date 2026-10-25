extends Area2D

@export var textbox: CanvasLayer
@export var tile_map: TileMapLayer

@export var door_cell: Vector2i=Vector2i(0,6)
@export var source_id: int = 1
@export var open_door_coords: Vector2i=Vector2i(4,8)

@export var locked: bool = true

var player_nearby: bool = false
var door_open: bool = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if door_cell.is_colliding():
		door_cell= door_cell
	
