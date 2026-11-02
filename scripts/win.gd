extends Control
@onready var textbox = $textbox

func _ready() -> void:
	textbox.animate_text("You made it out of daycare alive and got back to your family!", "n")
