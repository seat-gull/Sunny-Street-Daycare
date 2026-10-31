extends CanvasLayer

@onready var textbox_container = $textboxContainer
@onready var speaker_image = $textboxContainer/MarginContainer/HBoxContainer/VBoxContainer/speakerImage
@onready var speaker = $textboxContainer/MarginContainer/HBoxContainer/VBoxContainer/speaker
@onready var start_symbol = $textboxContainer/MarginContainer/HBoxContainer/start
@onready var end_symbol = $textboxContainer/MarginContainer/HBoxContainer/end
@onready var label = $textboxContainer/MarginContainer/HBoxContainer/text
const CHAR_READ_RATE= 0.02

var text_tween: Tween

func _ready() -> void:
	hide_textbox()

func hide_textbox() -> void:
	if text_tween and text_tween.is_running():
		text_tween.kill()
	
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	speaker.text = ""
	label.visible_characters = -1
	textbox_container.hide()
	
func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()
	
func show_message(message: String) -> void:
	if text_tween and text_tween.is_running():
		text_tween.kill()
		
	label.text = message
	speaker.text = "..."
	start_symbol.text = "*"
	end_symbol.text = "*"
	label.visible_characters = -1
	textbox_container.show()
	

func animate_text(next_text: String,talker: String) -> void:
	if text_tween and text_tween.is_running():
		text_tween.kill()
		
	label.text = next_text
	label.visible_characters = 0
	label.show()
	
	start_symbol.show()
	end_symbol.show()
	textbox_container.show()
		
	if talker == "n":
		speaker_image.hide()
		speaker.text = "..."
	
	elif talker == "Blobby":
		speaker_image.show()
		speaker.text = talker
		
	speaker.show()
		
	text_tween = create_tween()
	text_tween.set_trans(Tween.TRANS_SINE)
	text_tween.set_ease(Tween.EASE_OUT)
	text_tween.tween_property(label,"visible_characters",next_text.length(),next_text.length() * CHAR_READ_RATE)

	
