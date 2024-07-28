extends Asteroid

@onready var noise_border: Sprite2D = $NoiseBorder

func asteroid_skill() -> void:
	var index = randi() % 100
	if index < 90 and not is_skill:
		is_skill = true
		is_move = true
		noise_border.show()


func _on_timer_timeout() -> void:
	asteroid_skill()
