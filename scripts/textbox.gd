extends CanvasLayer

@onready var textbox_container = $textboxContainer
@onready var speaker_image = $textboxContainer/MarginContainer/HBoxContainer/VBoxContainer/speakerImage
@onready var speaker = $textboxContainer/MarginContainer/HBoxContainer/VBoxContainer/speaker
@onready var start_symbol = $textboxContainer/MarginContainer/HBoxContainer/start
@onready var end_symbol = $textboxContainer/MarginContainer/HBoxContainer/end
@onready var label = $textboxContainer/MarginContainer/HBoxContainer/text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_textbox()
	print('debug')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	speaker.text = ""
	textbox_container.hide()
	
func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()
