extends Asteroid

func asteroid_skill() -> void:
	var index = randi() % 100
	if index < 5 and not is_skill:
		is_skill = true
		speed /= 2
		sprite_2d.material = null


func _on_timer_timeout() -> void:
	asteroid_skill()
