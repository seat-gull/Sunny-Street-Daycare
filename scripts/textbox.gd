extends CanvasLayer

@onready var textbox_container = $textboxContainer
@onready var speaker_image = $textboxContainer/MarginContainer/HBoxContainer/VBoxContainer/speakerImage
@onready var speaker = $textboxContainer/MarginContainer/HBoxContainer/VBoxContainer/speaker
@onready var start_symbol = $textboxContainer/MarginContainer/HBoxContainer/start
@onready var end_symbol = $textboxContainer/MarginContainer/HBoxContainer/end
@onready var label = $textboxContainer/MarginContainer/HBoxContainer/text
const CHAR_READ_RATE= 0.03

func _ready() -> void:
	hide_textbox()
	print('debug')

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
	
func show_message(message: String) -> void:
	label.text = message
	speaker.text = "..."
	start_symbol.text = "*"
	end_symbol.text = "*"
	textbox_container.show()
	

func animate_text(next_text: String,talker: String) -> void:
	label.text = next_text
	label.visible_characters = 0
	label.show()
	start_symbol.show()
	end_symbol.show()
	textbox_container.show()
	speaker.text = talker
	
	if talker == "n":
		speaker_image.hide()
		speaker.text = "..."
	
	if talker == "Blobby":
		speaker_image.show()
		speaker.text = talker
		
	speaker.show()
		
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(label,"visible_characters",-1,next_text.length() * CHAR_READ_RATE)

	
