extends CanvasLayer

@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/Panel/MarginContainer/HBoxContainer/start
@onready var end_symbol = $TextboxContainer/Panel/MarginContainer/HBoxContainer/end
@onready var label = $TextboxContainer/Panel/MarginContainer/HBoxContainer/text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_textbox()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
