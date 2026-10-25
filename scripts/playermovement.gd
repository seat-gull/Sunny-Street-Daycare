extends CharacterBody2D

@export var movement_speed : float = 300
var direction : Vector2

func _physics_process(delta:float) -> void:
	direction.x = Input.get_axis("move_left","move_right")
	direction.y = Input.get_axis("move_up","move_down")
	direction = direction.normalized()
	
	#flipping 
	if direction.x > 0:
		$sprite.flip_h = false
	elif direction.x < 0:
		$sprite.flip_h = true
	
	if direction:
		velocity = direction * movement_speed
		if $sprite.animation != "walk":
			$sprite.animation = "walk"
	else:
		velocity = velocity.move_toward(Vector2.ZERO,movement_speed)
		if $sprite.animation != "idle":
			$sprite.animation = "idle"
		
	move_and_slide()
