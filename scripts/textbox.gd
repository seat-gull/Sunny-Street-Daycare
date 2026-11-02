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
	start_symbol.text = "*"
	end_symbol.text = "*"
	hide_textbox()

func hide_textbox() -> void:
	if text_tween and text_tween.is_running():
		text_tween.kill()
	speaker_image.hide()
	speaker.hide()
	label.hide()
	start_symbol.hide()
	end_symbol.hide()
	label.visible_characters = -1
	textbox_container.hide()
	
func show_message(message: String, talker: String) -> void:
	if text_tween and text_tween.is_running():
		text_tween.kill()
		
	label.text = message
	speaker.text = talker
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
	
	if talker != "n":
		if talker == "Blobby":
			speaker_image.texture = load("res://assets/blobbypfp.png")
		elif talker == "Malgretta":
			speaker_image.texture = load("res://assets/malgrettapfp.png")
		elif talker == "Mom":
			speaker_image.texture = load("res://assets/mompfp.png")
		elif talker == "Dad":
			speaker_image.texture = load("res://assets/dadpfp.png")
		speaker_image.show()
		speaker.text = talker
	else:
		speaker_image.hide()
		speaker.text = ""
		
	speaker.show()
		
	text_tween = create_tween()
	text_tween.set_trans(Tween.TRANS_SINE)
	text_tween.set_ease(Tween.EASE_OUT)
	text_tween.tween_property(label,"visible_characters",next_text.length(),next_text.length() * CHAR_READ_RATE)

	
