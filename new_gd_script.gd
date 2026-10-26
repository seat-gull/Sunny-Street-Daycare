extends Area2D
@export var textbox: CanvasLayer

func _on_body_entered(body) :
	textbox.animate_text("You got lunch!","n")
	queue_free()
	print("yayyay?????")
