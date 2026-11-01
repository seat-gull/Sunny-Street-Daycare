extends Node2D

const speed = 150 

func _process(delta): 
	position += transform.x + speed * delta

func _on_kill_timer_timeout() -> void:
		queue_free()
