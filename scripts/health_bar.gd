extends ProgressBar

@onready var timer = $Timer

var health = 0 : set = _set_health

func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	
	if health <= 0:
		queue_free()
	
	if health < prev_health: 
		timer.start()
func init_health(_health):
	health = _health
	max_value = health

	
